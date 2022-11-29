import { ValidationAcceptor, ValidationChecks, ValidationRegistry } from 'langium';
import { StAstType, Program, Declarations } from './generated/ast';
import type { StServices } from './st-module';

/**
 * Registry for validation checks.
 */
export class StValidationRegistry extends ValidationRegistry {
    constructor(services: StServices) {
        super(services);
        const validator = services.validation.StValidator;
        const checks: ValidationChecks<StAstType> = {
            Program: validator.checkPersonStartsWithCapital,
            Declarations: validator.checkDeclarationConstants
        };
        this.register(checks, validator);
    }
}

/**
 * Implementation of custom validations.
 */
export class StValidator {
    // checkModifierConstants(Modifier: Modifier, accept: ValidationAcceptor): void {
    //     type ObjectKey = keyof typeof Modifier;
    //     let count = 0;
    //     ['CONSTANT', 'RETAIN', 'PERSISTENT'].forEach((el: string) => {
    //         if (Modifier[<ObjectKey>el]) {
    //             count++;
    //         }
    //     });
    //     if (count > 1) {
    //         accept('error', `You may use not more that a single object modifier 'CONSTANT', 'RETAIN' or 'PERSISTENT'`, { node: Modifier });
    //     }
    // }

    checkDeclarationConstants(Declarations: Declarations, accept: ValidationAcceptor): void {
        if (Declarations.dec_constant) {
            ['CONSTANT', 'RETAIN', 'PERSISTENT'].forEach(el => {
                if (Declarations.dec_constant.filter(e => e === el).length > 1) {
                    accept('error', `Keyword ${el} is doubled`, { node: Declarations, property: 'dec_constant' });
                }
            });
        }
    }

    checkPersonStartsWithCapital(Program: Program, accept: ValidationAcceptor): void {
        if (Program.name) {
            console.log(Program);
            const firstChar = Program.name.substring(0, 1);
            if (firstChar.toUpperCase() !== firstChar) {
                accept('warning', 'Program name should start with a capital.', { node: Program, property: 'name' });
            }
        }
    }

}
