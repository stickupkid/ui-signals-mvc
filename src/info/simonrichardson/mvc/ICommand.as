package info.simonrichardson.mvc
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface ICommand extends IHook
	{
		
		function initialize(facade : IFacade, view : IView) : void;
	}
}
