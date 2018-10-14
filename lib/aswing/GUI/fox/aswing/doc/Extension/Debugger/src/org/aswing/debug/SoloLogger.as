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
 
import org.aswing.debug.Logger;

/**
 * @author iiley
 */
class org.aswing.debug.SoloLogger {
	
	public function traceReplacer(msg:String, position, file, line):Void{
		logWithLogger(getLogger(), msg, position, file, line);
	}
	
	public function logWithLogger(logger:Logger, msg:String, position, file, line):Void{
		var msgAddition:String = line == undefined ? "" : "\t" + "{" + position + ", " + file + ", " + line + "}";
	
		if(msg.charAt(0) == "/"){
			var type:String = msg.substr(0, 3);
			if(type == "/d/"){
				logger.debug(msg.substr(3) + msgAddition);
			}else if(type == "/w/"){
				logger.warnning(msg.substr(3) + msgAddition);
			}else if(type == "/e/"){
				logger.error(msg.substr(3) + msgAddition);
			}else if(type == "/i/"){
				logger.info(msg.substr(3) + msgAddition);
			}else{//default
				logger.info(msg + msgAddition);
			}
		}else{//default
			logger.info(msg + msgAddition);
		}
	}
	
	/**
	 * Override this method in subclass
	 */
	public function getLogger():Logger{
		return null;
	}
}