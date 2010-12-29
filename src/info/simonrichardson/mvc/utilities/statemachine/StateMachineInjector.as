package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.errors.AbstractMethodError;
	import info.simonrichardson.mvc.patterns.observer.SignalMap;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class StateMachineInjector extends SignalMap
	{

		public static const STATE_MACHINE_PROXY_NAME : String = "stateMachineProxyName";

		public static const STATE_MACHINE_MEDIATOR_NAME : String = "stateMachineMediatorName";
		
		public function inject() : void
		{
			const proxyName : String = STATE_MACHINE_PROXY_NAME;
			const proxy : StateMachineProxy = new StateMachineProxy(proxyName);

			defineStates(proxy);

			const mediatorName : String = STATE_MACHINE_MEDIATOR_NAME;
			const mediator : StateMachineMediator = new StateMachineMediator(mediatorName, proxyName);

			facade.registerProxy(proxy);
			facade.registerMediator(mediator);
		}

		public function defineStates(proxy : StateMachineProxy) : void
		{
			throw new AbstractMethodError();
		}
	}
}
