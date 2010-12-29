package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.mvc.patterns.observer.Hook;
	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class StateMachineChangedHook extends Hook
	{

		public static const CHANGED : String = "statemachine/hooks/changed";

		public function StateMachineChangedHook(listener : Function)
		{
			super(CHANGED, listener);
		}
	}
}
