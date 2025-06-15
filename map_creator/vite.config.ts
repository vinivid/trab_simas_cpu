import { defineConfig } from 'vite';
import path from 'path';

export default defineConfig({
  build: {
    outDir: 'build',
    lib: {
      entry: path.resolve(__dirname, 'src/main.ts'),
      name: 'MyBundle',
      fileName: 'bundle',
      formats: ['es'],
    },
  },
});