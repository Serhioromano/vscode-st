/*
 * generated by Xtext 2.25.0
 */
package org.xtext.example.iecst;


/**
 * Initialization support for running Xtext languages without Equinox extension registry.
 */
public class IECSTStandaloneSetup extends IECSTStandaloneSetupGenerated {

	public static void doSetup() {
		new IECSTStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}