/*
 * Copyright (c) 2005, xlands.com inc.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, 
 * are permitted provided that the following conditions are met:
 * 
 * 1) Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer.
 *  
 * 2) Redistributions in binary form must reproduce the above copyright notice, 
 *    this list of conditions and the following disclaimer in the documentation 
 *    and/or other materials provided with the distribution. 
 * 
 * 3) Neither the name of xlands.com inc. nor the names of its contributors may be used
 *    to endorse or promote products derived from this software without specific
 *    prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
 * POSSIBILITY OF SUCH DAMAGE.
 */
 
import org.aswing.debug.AWLogger;
import org.aswing.debug.Logger;
import org.aswing.debug.LuminicBoxLogger;
import org.aswing.debug.SoloLogger;
import org.aswing.debug.SOSLogger;
 
/**
 * Inspired by ZeroI probject, i improved this Log adapter at 2006.8.17.
 * <p>
 * Use MTASC compile param like this to turn on the loggers:
 * <pre>
 * -cp F:\workspace\Debugger\src 
 * -pack org/aswing/debug 
 * -trace org.aswing.debug.Log.log
 * </pre>
 * replace "F:\workspace\Debugger\src" to your debugger src location.
 * <p>
 * The trace has 4 level, they are:
 * <ul>
 * <li>Info by trace("/i/"+msg) or trace(msg) because this is the default level
 * <li>Debug by trace("/d/"+msg)
 * <li>Warning by trace("/w/"+msg)
 * <li>Error by trace("/e/"+msg)
 * <ul>
 * <p>
 * If you want to change to another specified Logger, you can do this:<br>
 * change org.aswing.debug.Log.log to:<br>
 * <ul>
 * <li>org.aswing.debug.Log.sosLog
 * <li>org.aswing.debug.Log.luminicBoxLog
 * <li>org.aswing.debug.Log.(other implemented Log method)
 * <ul>
 * @author iiley
 */
class org.aswing.debug.Log extends SoloLogger{
	
	private var logger:Logger;
	
	private static var instance:Log;
	private function Log(){
	}
	private static function getInstance():Log{
		if(instance == null){
			instance = new Log();
		}
		return instance;
	}
	
	/**
	 * Logs with default logger()
	 */
	public static function log(msg:String, position, file, line):Void{
		getInstance().logWithLogger(getInstance().getLogger(), msg, position, file, line);
	}
	
	private static var sosLogger:Logger;
	/**
	 * Logs with SOS Logger
	 */
	public static function sosLog(msg:String, position, file, line):Void{
		if(sosLogger == null){
			sosLogger = new SOSLogger();
		}
		getInstance().logWithLogger(sosLogger, msg, position, file, line);
	}
	
	private static var lbLogger:Logger;
	/**
	 * Logs with LuminicBox Logger
	 */	
	public static function luminicBoxLog(msg:String, position, file, line):Void{
		if(lbLogger == null){
			lbLogger = new LuminicBoxLogger();
		}
		getInstance().logWithLogger(lbLogger, msg, position, file, line);
	}	
	
	private static var awLogger:Logger;
	/**
	 * Logs with LuminicBox Logger
	 */	
	public static function awLog(msg:String, position, file, line):Void{
		if(awLogger == null){
			awLogger = new AWLogger();
		}
		getInstance().logWithLogger(awLogger, msg, position, file, line);
	}	
	
	/**
	 * Sets default logger
	 */
	public function setLogger(l:Logger):Void{
		logger = l;
	}
	
	/**
	 * Gets default logger(initially default is SOSLogger)
	 */
	public function getLogger():Logger{
		if(logger == null){
			logger = new SOSLogger();
		}
		return logger;
	}
}