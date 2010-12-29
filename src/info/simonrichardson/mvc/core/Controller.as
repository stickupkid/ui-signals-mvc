package info.simonrichardson.mvc.core
{
	import info.simonrichardson.mvc.IFacade;
	import info.simonrichardson.mvc.ICommand;
	import info.simonrichardson.mvc.IController;
	import info.simonrichardson.mvc.IView;

	import flash.utils.Dictionary;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class Controller implements IController
	{

		protected var view : IView;
		
		protected var facade : IFacade;

		protected var commandMap : Dictionary;

		public function Controller()
		{
			commandMap = new Dictionary(true);
		}

		public function initialize(facade : IFacade, view : IView) : void
		{
			this.view = view;
			this.facade = facade;
		}

		public function registerCommand(command : ICommand) : void
		{
			if (command.valueClasses.length != command.listener.length)
			{
				throw new ArgumentError('Invalid listener parameter length'); 
			}
			
			command.initialize(facade, view);
			
			if ( commandMap[ command.name ] == null )
			{
				view.addHook(command);
			}
			
			commandMap[ command.name ] = command;
		}

		public function removeCommand(command : ICommand) : void
		{
			if ( hasCommand(command.name) )
			{
				view.removeHook(command);
				commandMap[ command.name ] = null;
			}
		}

		public function hasCommand(commandName : String) : Boolean
		{
			return commandMap[ commandName ] != null;
		}
	}
}
