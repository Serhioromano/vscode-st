import { ValidationAcceptor, ValidationChecks, ValidationRegistry } from 'langium';
import { StAstType, Program } from './generated/ast';
import type { StServices } from './st-module';

/**
 * Registry for validation checks.
 */
export class StValidationRegistry extends ValidationRegistry {
    constructor(services: StServices) {
        super(services);
        const validator = services.validation.StValidator;
        const checks: ValidationChecks<StAstType> = {
            Program: validator.checkPersonStartsWithCapital
        };
        this.register(checks, validator);
    }
}

/**
 * Implementation of custom validations.
 */
export class StValidator {

    checkPersonStartsWithCapital(Program: Program, accept: ValidationAcceptor): void {
        if (Program.name) {
            const firstChar = Program.name.substring(0, 1);
            if (firstChar.toUpperCase() !== firstChar) {
                accept('warning', 'Program name should start with a capital.', { node: Program, property: 'name' });
            }
        }
    }

}
