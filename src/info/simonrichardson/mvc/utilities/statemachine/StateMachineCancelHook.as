package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.mvc.patterns.observer.Hook;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class StateMachineCancelHook extends Hook
	{

		public static const CANCEL : String = "statemachine/hooks/cancel";

		public function StateMachineCancelHook(listener : Function)
		{
			super(CANCEL, listener);
		}
	}
}
