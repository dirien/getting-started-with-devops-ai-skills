import * as aws from "@pulumi/aws";

// LSP DEMO — the kind of mistake an agent makes WITHOUT a language server.
// `publicReadAccess` is not a real property on BucketV2Args. With
// typescript-language-server wired (apm.yml → dependencies.lsp), the agent sees the
// red squiggle as it types and self-corrects. Without it, this only blows up at
// `tsc` / `pulumi preview` — or worse, the agent invents a plausible-looking API.
const bucket = new aws.s3.BucketV2("data", {
  publicReadAccess: true, // ❌ LSP: "Object literal may only specify known properties"
});

// The configured, type-checked version (what the agent should land on):
// const bucket = new aws.s3.BucketV2("data", {
//   tags: { team: "platform", env: "dev", "managed-by": "pulumi" },
// });

export const bucketName = bucket.bucket;
