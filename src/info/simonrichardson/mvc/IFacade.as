package info.simonrichardson.mvc
{
	import org.osflash.signals.ISignal;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IFacade
	{

		function registerProxy(proxy : IProxy) : void;

		function retrieveProxy(proxyName : String) : IProxy;

		function removeProxy(proxyName : String) : IProxy;

		function hasProxy(proxyName : String) : Boolean;

		function registerCommand(command : ICommand) : void;

		function removeCommand(command : ICommand) : void;

		function hasCommand(commandName : String) : Boolean;

		function registerMediator(mediator : IMediator) : void;

		function retrieveMediator(mediatorName : String) : IMediator;

		function removeMediator(mediatorName : String) : IMediator;

		function hasMediator(mediatorName : String) : Boolean;
		
		function getSignal(signalName : String) : ISignal;
	}
}
