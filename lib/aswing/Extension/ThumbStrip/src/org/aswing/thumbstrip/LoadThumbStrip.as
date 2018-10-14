/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.geom.Dimension;
import org.aswing.thumbstrip.LoadThumb;
import org.aswing.thumbstrip.ThumbStrip;
import org.aswing.util.StringUtils;

/**
 * @author Igor Sadovskiy
 * @version 1.0
 */
class org.aswing.thumbstrip.LoadThumbStrip extends ThumbStrip {
 
    /**
     * When selected image is changed.
     *<br>
     * onSelectionChanged(source:ImageThumbStrip, imageURL:String, imageTitle:String)
     */ 
    public static var ON_SELECTION_CHANGED:String = "onSelectionChanged";
 
 
    /** 
     * Specifies load all images at once mode. 
     */
    public static var LOAD_ALL:Number = 0;  
    /** 
     * Specifies partial load images mode. Allows simultaneous loading of the specified
     * amount of images. 
     */
    public static var LOAD_PARTIAL:Number = 1;  
    /** 
     * Specifies load visible image mode. Initially starts to load only visible images. After 
     * visible images are loaded start to load images im partial mode. 
     */
    public static var LOAD_VISIBLE:Number = 2;  
 
 
    /** Specifies default image loading mode. */
    public static var DEFAULT_LOAD_MODE:Number = LOAD_PARTIAL;
    
    /** Specifies default amount of the simultaneous loaading images in the #LOAD_PARTIAL mode. */
    public static var DEFAULT_LOAD_PARTIAL_AMOUNT:Number = 10;
     
    
    private var baseUrl:String;
    private var useBaseUrl:Boolean;
    
    private var useUrlAsTitle:Boolean;
    
    private var loadMode:Number;
    private var partialLoadAmount:Number;
    private var startedLoadAmount:Number;
    private var finishedLoadAmount:Number;
    
    /**
     * Constructs <code>ImageThumbStrip</code> instance.
     * 
     * @param images (optional) the array of the URI of images to load.
     * @param titles (optional) the array with imege's titles.
     */
    public function LoadThumbStrip(images:Array, titles:Array) {
        super();
        
        // init base url
        baseUrl = "";
        useBaseUrl = false;
        
        // init use URL as title flag
        useUrlAsTitle = true;
        
        // init image load modes
        loadMode = LOAD_PARTIAL;
        partialLoadAmount = DEFAULT_LOAD_PARTIAL_AMOUNT;
        
        // set images and titles
        setImages(images);
        setTitles(titles);
    }
    
    /**
     * Sets new base URL.
     * 
     * @param baseUrl the new base URL.
     */
    public function setBaseUrl(baseUrl:String):Void {
        this.baseUrl = baseUrl; 
    }

    /**
     * Returns current base URL.
     * 
     * @return current base URL.
     */
    public function getBaseUrl(Void):String {
        return baseUrl; 
    }

    /**
     * Sets use base URL flag.
     * 
     * @param useBaseUrl the use base URL flag.
     */
    public function setUseBaseUrl(useBaseUrl:Boolean):Void {
        this.useBaseUrl = useBaseUrl;   
    }

    /**
     * Returns current use base URL flag.
     * 
     * @return current use base URL flag.
     */
    public function isUseBaseUrl(Void):Boolean {
        return useBaseUrl;  
    }
    
    /**
     * Sets use URL as titles for images flag.
     * 
     * @param useUrlAsTitle the use URL as titles for images flag.
     */
    public function setUseUrlAsTitle(useUrlAsTitle:Boolean):Void {
        if (this.useUrlAsTitle != useUrlAsTitle) {
            this.useUrlAsTitle = useUrlAsTitle;
            
            // update titles
            if (useUrlAsTitle) {
                for (var i = 0; thumbs.getSize(); i++) {
                    var thumb:LoadThumb = LoadThumb(thumbs[i]);
                    if (thumb.getTitle() == null) {
                        thumb.setTitle(getTitleFromUrl(thumb.getUrl()));    
                    }   
                }   
            }
        }   
    }
    
    /**
     * Checks wherever URLs are used as titles for images.
     * 
     * @return the flag reflected wherever URLs are used as titles for images.
     */
    public function isUseUrlAsTitle(Void):Boolean {
        return useUrlAsTitle;   
    }
    
    /**
     * Returns image file name as title extracted from the URL.
     */
    private function getTitleFromUrl(url:String):String {

        var pos:Number = url.lastIndexOf("/");
        if (pos == -1) return url;
        
        url = url.substring(pos+1);
        pos = url.lastIndexOf(".");
        if (pos != -1) {
            url = url.substring(0, pos);    
        }
        
        return url;
    }
    
    /**
     * Sets new image load mode.
     * 
     * @param loadMode the new image load mode.
     * 
     * @see #LOAD_ALL
     * @see #LOAD_PARTIAL
     * @see #LOAD_VISIBLE
     */
    public function setImageLoadMode(loadMode:Number):Void {
        this.loadMode = loadMode;   
    }
    
    /**
     * Returns current image load mode.
     * 
     * @return image load mode.
     * 
     * @see #LOAD_ALL
     * @see #LOAD_PARTIAL
     * @see #LOAD_VISIBLE
     */
    public function getImageLoadMode(Void):Number {
        return loadMode;    
    }
    
    /**
     * Sets new <code>amount</code> of the simultaneously loading images in the
     * #LOAD_PARTIAL mode.
     * 
     * @param amount the amount of the simultaneously loaging images.
     * 
     * @see #LOAD_PARTIAL
     */
    public function setPartialLoadAmount(amount:Number):Void {
        partialLoadAmount = amount; 
    }

    /**
     * Returns amount of the simultaneously loading images in the
     * #LOAD_PARTIAL mode.
     * 
     * @return amount the amount of the simultaneously loaging images.
     * 
     * @see #LOAD_PARTIAL
     */
    public function getPartialLoadAmount(Void):Number {
        return partialLoadAmount;   
    }
    
    /**
     * Sets new images to display. Removes all existed images before.
     * 
     * @param images the array contained new images to display.
     */
    public function setImages(images:Array):Void {
        clearImages();
        
        for (var i = 0; i < images.length; i++) {
            var imageUrl:String = images[i];
            if (useBaseUrl) {
                if (StringUtils.endsWith(baseUrl, "/")) {
                    imageUrl = baseUrl + imageUrl;
                } else {
                    imageUrl = baseUrl + "/" + imageUrl;
                }
            } 
                        
            var imageThumb:LoadThumb = new LoadThumb(imageUrl, null, false);
            imageThumb.addEventListener(LoadThumb.ON_THUMB_LOADED, __onThumbLoaded, this);
            appendThumb(imageThumb);
        }
        
        startLoading();
    }
    
    /**
     * Returns currently displayed images.
     * 
     * @return the image URLs.
     */
    public function getImages(Void):Array {
        var images:Array = new Array();
        for (var i = 0; i < thumbs.size(); i++) {
            var imageThumb:LoadThumb = LoadThumb(thumbs.get(i));
            images.push(imageThumb.getUrl());   
        }
        return images;
    }

    /**
     * Sets new image titles to display. Replaces all existed image titles before.
     * 
     * @param titles the array contained new image titles to display.
     */
    public function setTitles(titles:Array):Void {
        for (var i = 0; i < thumbs.size(); i++) {
            var imageThumb:LoadThumb = LoadThumb(thumbs.get(i));
            var title:String = titles[i];
            if (title == null && useUrlAsTitle) {
                title = getTitleFromUrl(imageThumb.getUrl());
            }
            imageThumb.setTitle(title);
        }
    }
    
    /**
     * Returns currently displayed titles.
     * 
     * @return the image titles.
     */
    public function getTitles(Void):Array {
        var titles:Array = new Array();
        for (var i = 0; i < thumbs.size(); i++) {
            var imageThumb:LoadThumb = LoadThumb(thumbs.get(i));
            titles.push(imageThumb.getTitle()); 
        }
        return titles;
    }
    
    /**
     * Removes all images and its titles from the view.
     */
    public function clear(Void):Void {
        clearImages();
        clearTitles();
    }

    /**
     * Clears all images in the view.
     */
    private function clearImages(Void):Void {
        scrollContent.removeAll();
        thumbs.clear();
        startedLoadAmount = 0;
        finishedLoadAmount = 0;
    }
    
    /**
     * Clears all titles in the view.
     */
    private function clearTitles(Void):Void {
        for (var i = 0; i < thumbs.size(); i++) {
            var imageThumb:LoadThumb = LoadThumb(thumbs.get(i));
            imageThumb.setTitle("");    
        }
    }
    
    /**
     * Checks wherever image with the specified index can be loaded immediately.
     */
    private function isLoadImmediately(index:Number, prefSize:Dimension):Boolean {
        
        if (loadMode == LOAD_PARTIAL) {
            return (startedLoadAmount < partialLoadAmount);
        } else if (loadMode == LOAD_VISIBLE) {
            if (orientation == HORIZONTAL) {
                return (prefSize.width * index < scrollPane.getExtentSize().width); 
            } else if (orientation == VERTICAL) {
                return (prefSize.height * index < scrollPane.getExtentSize().height);
            } else {
                // TODO 
            }
        }
        return true;        
    }
    
    /**
     * Starts image loading.
     */
    private function startLoading(Void):Void {
        
        for (var i = 0; i < thumbs.getSize(); i++) {
            // TODO
            //if (isLoadImmediately(i, prefSize)) {
                var thumb:LoadThumb = LoadThumb(thumbs.get(i));
                thumb.load();
                startedLoadAmount++;
            //}
        }   
    }
    
    /**
     * Fires action event.
     */ 
    private function fireActionEvent(Void):Void {
    	var selectedImageThumb:LoadThumb = LoadThumb(selectedThumb);
    	dispatchEvent(createEventObj(ON_ACT, selectedImageThumb.getUrl(), selectedImageThumb.getTitle()));
    }
    
    /**
     * Fires selection changed event.
     */ 
    private function fireSelectionChangedEvent(Void):Void {
        var selectedImageThumb:LoadThumb = LoadThumb(selectedThumb);
        dispatchEvent(createEventObj(ON_SELECTION_CHANGED, selectedImageThumb.getUrl(), selectedImageThumb.getTitle()));
    }
    
    /** Handles image loading event. */
    private function __onThumbLoaded(thumb:LoadThumb):Void {
        revalidate();
        
        // increase finished amount
        finishedLoadAmount++;
        
        // srart to load next image
        if (startedLoadAmount < thumbs.getSize()) {
            LoadThumb(thumbs.get(startedLoadAmount)).load();
            startedLoadAmount++;    
        }   
    }
    
}

