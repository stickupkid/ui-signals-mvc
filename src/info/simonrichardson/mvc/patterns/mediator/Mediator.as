package info.simonrichardson.mvc.patterns.mediator
{
	import info.simonrichardson.mvc.IHook;
	import info.simonrichardson.mvc.IMediator;
	import info.simonrichardson.mvc.patterns.observer.SignalMap;
	import info.simonrichardson.ui.display.UISprite;

	import org.osflash.signals.ISignal;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class Mediator extends SignalMap implements IMediator
	{
		
		public static const VIEW_COMPONENT_CHANGED : String = "viewComponentChanged";
		
		protected var _viewComponent : UISprite;

		public function Mediator(name : String, viewComponent : UISprite = null)
		{
			super(name);
			
			_viewComponent = viewComponent;
		}

		public function listSignalHooks() : Vector.<IHook>
		{
			return new Vector.<IHook>();
		}

		public function onRegister() : void
		{
		}

		public function onRemove() : void
		{
		}

		public function get viewComponent() : UISprite
		{
			return _viewComponent;
		}

		public function set viewComponent(value : UISprite) : void
		{
			if (_viewComponent == value)
			{
				return;
			}

			if (null != _viewComponent)
			{
				_viewComponent.dispose();
				_viewComponent = null;
			}
			
			_viewComponent = value;
			
			const signal : ISignal = getSignal(VIEW_COMPONENT_CHANGED);
			signal.dispatch(this, viewComponent);
		}
	}
}
