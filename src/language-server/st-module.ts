import {
    createDefaultModule, createDefaultSharedModule, DefaultSharedModuleContext, inject,
    LangiumServices, LangiumSharedServices, Module, PartialLangiumServices
} from 'langium';
import { StructuredTextGeneratedModule, StGeneratedSharedModule } from './generated/module';
import { StValidationRegistry, StValidator } from './st-validator';

/**
 * Declaration of custom services - add your own service classes here.
 */
export type StAddedServices = {
    validation: {
        StValidator: StValidator
    }
};

/**
 * Union of Langium default services and your custom services - use this as constructor parameter
 * of custom service classes.
 */
export type StServices = LangiumServices & StAddedServices;

/**
 * Dependency injection module that overrides Langium default services and contributes the
 * declared custom services. The Langium defaults can be partially specified to override only
 * selected services, while the custom services must be fully specified.
 */
export const StModule: Module<StServices, PartialLangiumServices & StAddedServices> = {
    validation: {
        ValidationRegistry: (services) => new StValidationRegistry(services),
        StValidator: () => new StValidator()
    }
};

/**
 * Create the full set of services required by Langium.
 *
 * First inject the shared services by merging two modules:
 *  - Langium default shared services
 *  - Services generated by langium-cli
 *
 * Then inject the language-specific services by merging three modules:
 *  - Langium default language-specific services
 *  - Services generated by langium-cli
 *  - Services specified in this file
 *
 * @param context Optional module context with the LSP connection
 * @returns An object wrapping the shared services and the language-specific services
 */
export function createStServices(context: DefaultSharedModuleContext): {
    shared: LangiumSharedServices,
    St: StServices
} {
    const shared = inject(
        createDefaultSharedModule(context),
        StGeneratedSharedModule
    );
    const St = inject(
        createDefaultModule({ shared }),
        StructuredTextGeneratedModule,
        StModule
    );
    shared.ServiceRegistry.register(St);
    return { shared, St };
}