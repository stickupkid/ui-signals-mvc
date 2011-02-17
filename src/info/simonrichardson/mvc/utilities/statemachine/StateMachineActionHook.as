package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.mvc.patterns.observer.Hook;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class StateMachineActionHook extends Hook
	{

		public static const ACTION : String = "stateMachine/hooks/action";

		public function StateMachineActionHook(listener : Function)
		{
			super(ACTION, listener, [String]);
		}
	}
}
