package info.simonrichardson.mvc
{
	import org.osflash.signals.ISignal;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public interface ISignalMap
	{
		
		function initialize(facade : IFacade, view : IView) : void;

		function getSignal(signalName : String) : ISignal;
		
		function get name() : String;
	}
}
