import * as esbuild from 'esbuild';

// Extension bundle
await esbuild.build({
    entryPoints: ['src/extension.ts'],
    bundle: true,
    outfile: 'out/extension.js',
    external: ['vscode'],
    format: 'cjs',
    platform: 'node',
    sourcemap: true,
});

// Language server bundle
await esbuild.build({
    entryPoints: ['src/lsp/main.ts'],
    bundle: true,
    outfile: 'out/lsp-server.js',
    external: ['vscode'],
    format: 'cjs',
    platform: 'node',
    sourcemap: true,
});
