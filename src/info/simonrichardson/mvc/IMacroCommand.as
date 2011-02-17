package info.simonrichardson.mvc
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IMacroCommand extends ICommand
	{

		function addCommand(command : ICommand) : void;

		function removeCommand(command : ICommand) : void;

		function hasCommand(command : ICommand) : Boolean;
	}
}
