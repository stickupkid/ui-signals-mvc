package info.simonrichardson.mvc
{
	import org.osflash.signals.ISignal;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IView
	{

		function initialize(facade : IFacade) : void;

		function addHook(hook : IHook) : void;

		function removeHook(hook : IHook) : void;

		function getSignal(signalName : String) : ISignal;

		function registerMediator(mediator : IMediator) : void;

		function retrieveMediator(mediatorName : String) : IMediator;

		function removeMediator(mediatorName : String) : IMediator;

		function hasMediator(mediatorName : String) : Boolean;
	}
}
