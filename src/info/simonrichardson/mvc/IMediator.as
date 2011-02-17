package info.simonrichardson.mvc
{
	import info.simonrichardson.ui.display.UISprite;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IMediator extends ISignalMap
	{

		function listSignalHooks() : Vector.<IHook>;

		function onRegister() : void;

		function onRemove() : void;

		function get viewComponent() : UISprite;

		function set viewComponent(value : UISprite) : void;
	}
}
