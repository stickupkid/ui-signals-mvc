package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.mvc.patterns.observer.Hook;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class StateMachineActionHook extends Hook
	{

		public static const ACTION : String = "stateMachine/hooks/action";
		
		public static const NEXT_STATE : String = "stateMachine/notifications/nextState";
		
		public static const NEXT_INTERNAL_STATE : String = "stateMachine/notifications/nextInternalState";

		public function StateMachineActionHook(listener : Function)
		{
			super(ACTION, listener, [String]);
		}
	}
}
