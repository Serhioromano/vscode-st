import chalk from 'chalk';
import { Command } from 'commander';
import { Model } from '../language-server/generated/ast';
import { StLanguageMetaData } from '../language-server/generated/module';
import { createStServices } from '../language-server/st-module';
import { extractAstNode } from './cli-util';
import { generateJavaScript } from './generator';
import { NodeFileSystem } from 'langium/node';

export const generateAction = async (fileName: string, opts: GenerateOptions): Promise<void> => {
    const services = createStServices(NodeFileSystem).St;
    const model = await extractAstNode<Model>(fileName, services);
    const generatedFilePath = generateJavaScript(model, fileName, opts.destination);
    console.log(chalk.green(`JavaScript code generated successfully: ${generatedFilePath}`));
};

export type GenerateOptions = {
    destination?: string;
}

export default function(): void {
    const program = new Command();

    program
        // eslint-disable-next-line @typescript-eslint/no-var-requires
        .version(require('../../package.json').version);

    const fileExtensions = StLanguageMetaData.fileExtensions.join(', ');
    program
        .command('generate')
        .argument('<file>', `source file (possible file extensions: ${fileExtensions})`)
        .option('-d, --destination <dir>', 'destination directory of generating')
        .description('generates JavaScript code that prints "Hello, {name}!" for each greeting in a source file')
        .action(generateAction);

    program.parse(process.argv);
}
