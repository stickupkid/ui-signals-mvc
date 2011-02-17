package info.simonrichardson.mvc
{
	import org.osflash.signals.ISignal;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface ISignalMap
	{
		
		function initialize(facade : IFacade, view : IView) : void;

		function getSignal(signalName : String) : ISignal;
		
		function get name() : String;
	}
}
