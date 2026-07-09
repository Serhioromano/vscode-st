import { type Module, inject } from 'langium';
import {
    createDefaultModule,
    createDefaultSharedModule,
    type DefaultSharedModuleContext,
    type LangiumServices,
    type LangiumSharedServices,
    type PartialLangiumServices,
} from 'langium/lsp';
import {
    StGeneratedModule,
    VscodeStGeneratedSharedModule,
} from './generated/module.js';
import { StValidator, registerValidationChecks } from './st-validator.js';
import { StFormatter } from './st-formatter.js';
import { StScopeComputation } from './st-scope.js';

export type StAddedServices = {
    validation: {
        StValidator: StValidator;
    };
};

export type StServices = LangiumServices & StAddedServices;

export const StModule: Module<
    StServices,
    PartialLangiumServices & StAddedServices
> = {
    references: {
        ScopeComputation: (services) => new StScopeComputation(services),
    },
    validation: {
        StValidator: () => new StValidator(),
    },
    lsp: {
        Formatter: () => new StFormatter(),
    },
};

export function createStServices(context: DefaultSharedModuleContext): {
    shared: LangiumSharedServices;
    st: StServices;
} {
    const shared = inject(
        createDefaultSharedModule(context),
        VscodeStGeneratedSharedModule
    );
    const st = inject(
        createDefaultModule({ shared }),
        StGeneratedModule,
        StModule
    );
    shared.ServiceRegistry.register(st);
    registerValidationChecks(st);
    return { shared, st };
}
