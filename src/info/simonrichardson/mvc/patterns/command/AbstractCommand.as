package info.simonrichardson.mvc.patterns.command
{
	import info.simonrichardson.mvc.ICommand;
	import info.simonrichardson.mvc.patterns.observer.SignalMap;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class AbstractCommand extends SignalMap implements ICommand
	{

		public function AbstractCommand(name : String)
		{
			super(name);
		}

		protected function execute() : void
		{
		}

		public function get listener() : Function
		{
			return execute;
		}

		public function get valueClasses() : Array
		{
			return null;
		}
	}
}