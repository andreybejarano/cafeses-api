// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from "std/server"
import { createClient } from '@supabase/supabase-js'
import {
  AccountId,
  PrivateKey,
  Client,
  Hbar,
  TokenCreateTransaction,
  TokenType,
  TokenSupplyType,
  TokenMintTransaction,
  TransferTransaction,
  AccountBalanceQuery,
  TokenAssociateTransaction
} from '@hashgraph/sdk'

import { corsHeaders } from '../_shared/cors.ts'

interface ProductData {
  name?: string | null;
}

async function createtNft(name?: string | null) {
  const operatorId = AccountId.fromString(Deno.env.get('HEDERA_OPERATOR_ID') || '')
  const operatorKey = PrivateKey.fromString(Deno.env.get('HEDERA_OPERATOR_PVKEY') || '')
  const treasuryId = AccountId.fromString(Deno.env.get('HEDERA_TREASURY_ID') || '')
  const treasuryKey = PrivateKey.fromString(Deno.env.get('HEDERA_TREASURY_PVKEY') || '')
  const aliceId = AccountId.fromString(Deno.env.get('HEDERA_ALICE_ID') || '')
  const aliceKey = PrivateKey.fromString(Deno.env.get('HEDERA_ALICE_PVKEY') || '')

  if (!operatorId || !operatorKey) {
    throw new Error("Environment variables MY_ACCOUNT_ID and MY_PRIVATE_KEY must be present");
  }
  const client = Client.forTestnet().setOperator(operatorId, operatorKey);

  const supplyKey = PrivateKey.generate();
  if (name) {

    const nftCreate = await new TokenCreateTransaction()
    .setTokenName(name)
    .setTokenSymbol("GRAD")
    .setTokenType(TokenType.NonFungibleUnique)
    .setDecimals(0)
    .setInitialSupply(0)
    .setTreasuryAccountId(treasuryId)
    .setSupplyType(TokenSupplyType.Finite)
    .setMaxSupply(250)
    .setSupplyKey(supplyKey)
    .freezeWith(client)
    
    const nftCreateTxSign = await nftCreate.sign(treasuryKey)
    const nftCreateSubmit = await nftCreateTxSign.execute(client)
    const nftCreateRx = await nftCreateSubmit.getReceipt(client)
    const tokenId = nftCreateRx.tokenId
    return tokenId
  }
  return ''
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  const { method } = req
  if (method === 'POST') {
    const form = await req.formData()
    let file: File | null = null;
    const body: ProductData = {};
    if (form) {
      body.name = form.get('name') as string
      file = form.get('image') as File
    }
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      { global: { headers: { Authorization: req.headers.get('Authorization')! } } }
    )
    if (file) {
      const filename = `${Date.now()}.${file.name.split('.').pop()}`
      const { data, error } = await supabaseClient.storage
        .from('products')
        .upload(filename, file)
      if (error) {
        return new Response(
          JSON.stringify({ status: 500, error }),
          { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 500 }
        )
      } else {
        const url = await supabaseClient.storage.from('products').getPublicUrl(data.path)
        console.log(url);
      }
    }
    const token = await createtNft(body?.name)
    const data = {
      message: `Created NFT with Token ID: ${token}`
    }
    return new Response(
      JSON.stringify(data),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } },
    )
  }
  return new Response(
    JSON.stringify({ status: 404, error: 'Resorce not found' }),
    { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 404 }
  )
})

// To invoke:
// curl -i --location --request POST 'http://localhost:54321/functions/v1/' \
//   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
//   --header 'Content-Type: application/json' \
//   --data '{"name":"Functions"}'
