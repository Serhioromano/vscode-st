import type { ValidationAcceptor, ValidationChecks } from 'langium';
import type { StServices } from './st-module.js';
import type { StProgram } from './generated/ast.js';

export class StValidator {
    // Phase 6b: validation methods will be added here.
    // Example:
    //   checkUniquePouNames(program: StProgram, accept: ValidationAcceptor): void { ... }
}

/**
 * Registers validation checks on the given services.
 * Placeholder — no checks registered yet.
 */
export function registerValidationChecks(services: StServices): void {
    // Phase 6b: register semantic validation rules.
    // Example:
    //   registry.register<StProgram>(
    //       { StProgram: validator.checkUniquePouNames },
    //       validator
    //   );
}
