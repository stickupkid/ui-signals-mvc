package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.mvc.patterns.observer.Hook;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class StateMachineCancelHook extends Hook
	{

		public static const CANCEL : String = "statemachine/hooks/cancel";

		public function StateMachineCancelHook(listener : Function)
		{
			super(CANCEL, listener);
		}
	}
}
