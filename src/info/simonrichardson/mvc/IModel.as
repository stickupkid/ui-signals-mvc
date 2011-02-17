package info.simonrichardson.mvc
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IModel
	{
		
		function initialize(facade : IFacade, view : IView) : void;

		function registerProxy(proxy : IProxy) : void;

		function retrieveProxy(proxyName : String) : IProxy;

		function removeProxy(proxyName : String) : IProxy;

		function hasProxy(proxyName : String) : Boolean;
	}
}
