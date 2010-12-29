package info.simonrichardson.mvc
{
	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public interface IController
	{
		
		function initialize(facade : IFacade, view : IView) : void;
		
		function registerCommand(command : ICommand) : void;

		function removeCommand(command : ICommand) : void;

		function hasCommand(commandName : String) : Boolean;
	}
}
