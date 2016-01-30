FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� LibrarySupportLib -- various standardized handlers for coercing and checking parameters and throwing errors

Notes:

- Because AS errors don't include stack traces, a library's public handlers must trap and rethrow all errors, prefixing error string with library and handler name (and, in script object methods, the object's display/documentation name) so that user can identify the handler in which an error occurred. Special attention should also be paid to coercing and/or validating public handlers' parameters, and throwing descriptive errors if an inappropriate value is given.

- This library wouldn't be necessary if AppleScript had decent parameter type annotations and proper exception objects (with full stack trace support). But as it doesn't these handlers at least take some of the endless pain out of sanitizing user-supplied inputs and generating consistent error messages when those inputs are inappropriate, or anything else in the handler needs to throw an error (or just goes plain old wrong).

- When coercing a text value to integer/real/number, or an integer or real value to text, the text is parsed/formatted using the current user's localization settings.

- When coercing a list to text, AppleScript's current text item delimiters are used. (This may change in future.)


Caution:

- When checking if a string is empty in a library handler, it is *essential* either to check its length=0 or else wrap the string comparison (e.g. `aString is ""`) in a `considering hyphens, punctuation and white space block` to ensure that it really is empty and not a non-empty text value that contains only characters being ignored by the caller's current considering/ignoring settings. Similarly, when comparing for a non-empty string, the considering block *must* be used.

- When performing comparisons using <,�,>,� operators or concatenating values with & operator, it is *essential* to ensure the left operand is of the correct type (number/text/date/list) as AS will coerce the RH operand to the same type as the LH operand, and in some cases even casts *both* (e.g. `1&2`->`{1}&{2}`->`{1,2}`). Conversely, when using =/� operators, if the two operands are not the same type then this will almost always result in `false` (the obvious exception being integer/real comparisons, e.g. `1=1.0`->true), even though type-only differences are often ignored by other operators/commands (e.g. `1<"1"->false, `1<{1}`->false). Fully sanitizing all handler parameters before using them should generally avoid such problems subsequently manifesting in the handler, but eternal vigilance is still required to ensure extremely obscure/nasty/unpredictable/almost-impossible-to-troubleshoot bugs don't sneak in.

TO DO:

- what to call this library? e.g. `HandlerLib`, `SupportLib`, `UtilityLib`, `Handler Tools`? e.g. if it starts getting handlers for general AS-to-ASOC conversion, not just for sanitizing 'user' inputs, it's no longer specifically intended for use in library-style handlers (also, if it does become general support lib, the `native type`, `check type`, and `convert to Cocoa` commands in TypesLib should move to here, as non-SDEF handlers)

- ensure `asTYPEParameter` handlers always accept ASOC objects, coercing to corresponding AS type (i.e. don't add any checks that'd cause them to reject 'ocid' specifiers), e.g. `asNumberParameter` will probably currently fail on ASOC object as it doesn't first coerce to `any`; might be best if a;l asTYPEParameter handlers first coerce to `any` before coercing to actual required type (the only exception would be an `asReferenceParameter` handler, as that needs to typecheck only, as coercing a reference dereferences it)

- should asTextParameter() always throw an error if value is a list? (i.e. avoids inconsistent concatenation results due to TIDs); another option would be to whitelist some or all known 'safe' types (integer/real, text, date, alias/file/furl, etc) and reject everything else; this should ensure stable predictable behavior - even where additional custom coercion handlers are installed (users can still use other types of values, of course; they just have to explicitly coerce them first using `as` operator)

- should as<NumericType>Parameter() handlers explicitly check for and reject non-number-like values that AS would normally coerce to numbers? Probably, e.g. just because January..December and Monday..Sunday constants _can_ coerce doesn't mean they should, as if they're being passed to a handler that expects a regular number then it almost certainly indicates a mistake in the user's code that should be drawn to her attention. For example, using Standard Additions:

	random number from January to December --> 0.0-1.0 (wrong! this is a bug in `random number` osax handler where it silently ignores non-numeric parameter types instead of reporting coercion error)	random number from (January as integer) to (December as integer) --> 1-12
	
	(Caveat: see above about not rejecting ASOC objects. Will need to be careful to allow NSNumber/NSString, though not NSAppleEventDescriptor)

 - `missing value` and other type/constant symbols are currently accepted by asTextParameter (though may coerce to either keyword name text or raw chevron text, which may be a reason for `asTextParameter` to disallow them; see also handling of month and weekday constants in `asInteger/Real/NumberParameter`) so will not trigger -1703; script objects, app refs, etc. will trigger -1708 due to direct parameter dispatch (i.e. `uppercase text` gets dispatched to them instead of TextLib) 
     � 	 	+�   L i b r a r y S u p p o r t L i b   - -   v a r i o u s   s t a n d a r d i z e d   h a n d l e r s   f o r   c o e r c i n g   a n d   c h e c k i n g   p a r a m e t e r s   a n d   t h r o w i n g   e r r o r s 
 
 N o t e s : 
 
 -   B e c a u s e   A S   e r r o r s   d o n ' t   i n c l u d e   s t a c k   t r a c e s ,   a   l i b r a r y ' s   p u b l i c   h a n d l e r s   m u s t   t r a p   a n d   r e t h r o w   a l l   e r r o r s ,   p r e f i x i n g   e r r o r   s t r i n g   w i t h   l i b r a r y   a n d   h a n d l e r   n a m e   ( a n d ,   i n   s c r i p t   o b j e c t   m e t h o d s ,   t h e   o b j e c t ' s   d i s p l a y / d o c u m e n t a t i o n   n a m e )   s o   t h a t   u s e r   c a n   i d e n t i f y   t h e   h a n d l e r   i n   w h i c h   a n   e r r o r   o c c u r r e d .   S p e c i a l   a t t e n t i o n   s h o u l d   a l s o   b e   p a i d   t o   c o e r c i n g   a n d / o r   v a l i d a t i n g   p u b l i c   h a n d l e r s '   p a r a m e t e r s ,   a n d   t h r o w i n g   d e s c r i p t i v e   e r r o r s   i f   a n   i n a p p r o p r i a t e   v a l u e   i s   g i v e n . 
 
 -   T h i s   l i b r a r y   w o u l d n ' t   b e   n e c e s s a r y   i f   A p p l e S c r i p t   h a d   d e c e n t   p a r a m e t e r   t y p e   a n n o t a t i o n s   a n d   p r o p e r   e x c e p t i o n   o b j e c t s   ( w i t h   f u l l   s t a c k   t r a c e   s u p p o r t ) .   B u t   a s   i t   d o e s n ' t   t h e s e   h a n d l e r s   a t   l e a s t   t a k e   s o m e   o f   t h e   e n d l e s s   p a i n   o u t   o f   s a n i t i z i n g   u s e r - s u p p l i e d   i n p u t s   a n d   g e n e r a t i n g   c o n s i s t e n t   e r r o r   m e s s a g e s   w h e n   t h o s e   i n p u t s   a r e   i n a p p r o p r i a t e ,   o r   a n y t h i n g   e l s e   i n   t h e   h a n d l e r   n e e d s   t o   t h r o w   a n   e r r o r   ( o r   j u s t   g o e s   p l a i n   o l d   w r o n g ) . 
 
 -   W h e n   c o e r c i n g   a   t e x t   v a l u e   t o   i n t e g e r / r e a l / n u m b e r ,   o r   a n   i n t e g e r   o r   r e a l   v a l u e   t o   t e x t ,   t h e   t e x t   i s   p a r s e d / f o r m a t t e d   u s i n g   t h e   c u r r e n t   u s e r ' s   l o c a l i z a t i o n   s e t t i n g s . 
 
 -   W h e n   c o e r c i n g   a   l i s t   t o   t e x t ,   A p p l e S c r i p t ' s   c u r r e n t   t e x t   i t e m   d e l i m i t e r s   a r e   u s e d .   ( T h i s   m a y   c h a n g e   i n   f u t u r e . ) 
 
 
 C a u t i o n : 
 
 -   W h e n   c h e c k i n g   i f   a   s t r i n g   i s   e m p t y   i n   a   l i b r a r y   h a n d l e r ,   i t   i s   * e s s e n t i a l *   e i t h e r   t o   c h e c k   i t s   l e n g t h = 0   o r   e l s e   w r a p   t h e   s t r i n g   c o m p a r i s o n   ( e . g .   ` a S t r i n g   i s   " " ` )   i n   a   ` c o n s i d e r i n g   h y p h e n s ,   p u n c t u a t i o n   a n d   w h i t e   s p a c e   b l o c k `   t o   e n s u r e   t h a t   i t   r e a l l y   i s   e m p t y   a n d   n o t   a   n o n - e m p t y   t e x t   v a l u e   t h a t   c o n t a i n s   o n l y   c h a r a c t e r s   b e i n g   i g n o r e d   b y   t h e   c a l l e r ' s   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s .   S i m i l a r l y ,   w h e n   c o m p a r i n g   f o r   a   n o n - e m p t y   s t r i n g ,   t h e   c o n s i d e r i n g   b l o c k   * m u s t *   b e   u s e d . 
 
 -   W h e n   p e r f o r m i n g   c o m p a r i s o n s   u s i n g   < ,"d , > ,"e   o p e r a t o r s   o r   c o n c a t e n a t i n g   v a l u e s   w i t h   &   o p e r a t o r ,   i t   i s   * e s s e n t i a l *   t o   e n s u r e   t h e   l e f t   o p e r a n d   i s   o f   t h e   c o r r e c t   t y p e   ( n u m b e r / t e x t / d a t e / l i s t )   a s   A S   w i l l   c o e r c e   t h e   R H   o p e r a n d   t o   t h e   s a m e   t y p e   a s   t h e   L H   o p e r a n d ,   a n d   i n   s o m e   c a s e s   e v e n   c a s t s   * b o t h *   ( e . g .   ` 1 & 2 ` - > ` { 1 } & { 2 } ` - > ` { 1 , 2 } ` ) .   C o n v e r s e l y ,   w h e n   u s i n g   = /"`   o p e r a t o r s ,   i f   t h e   t w o   o p e r a n d s   a r e   n o t   t h e   s a m e   t y p e   t h e n   t h i s   w i l l   a l m o s t   a l w a y s   r e s u l t   i n   ` f a l s e `   ( t h e   o b v i o u s   e x c e p t i o n   b e i n g   i n t e g e r / r e a l   c o m p a r i s o n s ,   e . g .   ` 1 = 1 . 0 ` - > t r u e ) ,   e v e n   t h o u g h   t y p e - o n l y   d i f f e r e n c e s   a r e   o f t e n   i g n o r e d   b y   o t h e r   o p e r a t o r s / c o m m a n d s   ( e . g .   ` 1 < " 1 " - > f a l s e ,   ` 1 < { 1 } ` - > f a l s e ) .   F u l l y   s a n i t i z i n g   a l l   h a n d l e r   p a r a m e t e r s   b e f o r e   u s i n g   t h e m   s h o u l d   g e n e r a l l y   a v o i d   s u c h   p r o b l e m s   s u b s e q u e n t l y   m a n i f e s t i n g   i n   t h e   h a n d l e r ,   b u t   e t e r n a l   v i g i l a n c e   i s   s t i l l   r e q u i r e d   t o   e n s u r e   e x t r e m e l y   o b s c u r e / n a s t y / u n p r e d i c t a b l e / a l m o s t - i m p o s s i b l e - t o - t r o u b l e s h o o t   b u g s   d o n ' t   s n e a k   i n . 
 
 T O   D O : 
 
 -   w h a t   t o   c a l l   t h i s   l i b r a r y ?   e . g .   ` H a n d l e r L i b ` ,   ` S u p p o r t L i b ` ,   ` U t i l i t y L i b ` ,   ` H a n d l e r   T o o l s ` ?   e . g .   i f   i t   s t a r t s   g e t t i n g   h a n d l e r s   f o r   g e n e r a l   A S - t o - A S O C   c o n v e r s i o n ,   n o t   j u s t   f o r   s a n i t i z i n g   ' u s e r '   i n p u t s ,   i t ' s   n o   l o n g e r   s p e c i f i c a l l y   i n t e n d e d   f o r   u s e   i n   l i b r a r y - s t y l e   h a n d l e r s   ( a l s o ,   i f   i t   d o e s   b e c o m e   g e n e r a l   s u p p o r t   l i b ,   t h e   ` n a t i v e   t y p e ` ,   ` c h e c k   t y p e ` ,   a n d   ` c o n v e r t   t o   C o c o a `   c o m m a n d s   i n   T y p e s L i b   s h o u l d   m o v e   t o   h e r e ,   a s   n o n - S D E F   h a n d l e r s ) 
 
 -   e n s u r e   ` a s T Y P E P a r a m e t e r `   h a n d l e r s   a l w a y s   a c c e p t   A S O C   o b j e c t s ,   c o e r c i n g   t o   c o r r e s p o n d i n g   A S   t y p e   ( i . e .   d o n ' t   a d d   a n y   c h e c k s   t h a t ' d   c a u s e   t h e m   t o   r e j e c t   ' o c i d '   s p e c i f i e r s ) ,   e . g .   ` a s N u m b e r P a r a m e t e r `   w i l l   p r o b a b l y   c u r r e n t l y   f a i l   o n   A S O C   o b j e c t   a s   i t   d o e s n ' t   f i r s t   c o e r c e   t o   ` a n y ` ;   m i g h t   b e   b e s t   i f   a ; l   a s T Y P E P a r a m e t e r   h a n d l e r s   f i r s t   c o e r c e   t o   ` a n y `   b e f o r e   c o e r c i n g   t o   a c t u a l   r e q u i r e d   t y p e   ( t h e   o n l y   e x c e p t i o n   w o u l d   b e   a n   ` a s R e f e r e n c e P a r a m e t e r `   h a n d l e r ,   a s   t h a t   n e e d s   t o   t y p e c h e c k   o n l y ,   a s   c o e r c i n g   a   r e f e r e n c e   d e r e f e r e n c e s   i t ) 
 
 -   s h o u l d   a s T e x t P a r a m e t e r ( )   a l w a y s   t h r o w   a n   e r r o r   i f   v a l u e   i s   a   l i s t ?   ( i . e .   a v o i d s   i n c o n s i s t e n t   c o n c a t e n a t i o n   r e s u l t s   d u e   t o   T I D s ) ;   a n o t h e r   o p t i o n   w o u l d   b e   t o   w h i t e l i s t   s o m e   o r   a l l   k n o w n   ' s a f e '   t y p e s   ( i n t e g e r / r e a l ,   t e x t ,   d a t e ,   a l i a s / f i l e / f u r l ,   e t c )   a n d   r e j e c t   e v e r y t h i n g   e l s e ;   t h i s   s h o u l d   e n s u r e   s t a b l e   p r e d i c t a b l e   b e h a v i o r   -   e v e n   w h e r e   a d d i t i o n a l   c u s t o m   c o e r c i o n   h a n d l e r s   a r e   i n s t a l l e d   ( u s e r s   c a n   s t i l l   u s e   o t h e r   t y p e s   o f   v a l u e s ,   o f   c o u r s e ;   t h e y   j u s t   h a v e   t o   e x p l i c i t l y   c o e r c e   t h e m   f i r s t   u s i n g   ` a s `   o p e r a t o r )  
 
 -   s h o u l d   a s < N u m e r i c T y p e > P a r a m e t e r ( )   h a n d l e r s   e x p l i c i t l y   c h e c k   f o r   a n d   r e j e c t   n o n - n u m b e r - l i k e   v a l u e s   t h a t   A S   w o u l d   n o r m a l l y   c o e r c e   t o   n u m b e r s ?   P r o b a b l y ,   e . g .   j u s t   b e c a u s e   J a n u a r y . . D e c e m b e r   a n d   M o n d a y . . S u n d a y   c o n s t a n t s   _ c a n _   c o e r c e   d o e s n ' t   m e a n   t h e y   s h o u l d ,   a s   i f   t h e y ' r e   b e i n g   p a s s e d   t o   a   h a n d l e r   t h a t   e x p e c t s   a   r e g u l a r   n u m b e r   t h e n   i t   a l m o s t   c e r t a i n l y   i n d i c a t e s   a   m i s t a k e   i n   t h e   u s e r ' s   c o d e   t h a t   s h o u l d   b e   d r a w n   t o   h e r   a t t e n t i o n .   F o r   e x a m p l e ,   u s i n g   S t a n d a r d   A d d i t i o n s : 
 
 	 r a n d o m   n u m b e r   f r o m   J a n u a r y   t o   D e c e m b e r   - - >   0 . 0 - 1 . 0   ( w r o n g !   t h i s   i s   a   b u g   i n   ` r a n d o m   n u m b e r `   o s a x   h a n d l e r   w h e r e   i t   s i l e n t l y   i g n o r e s   n o n - n u m e r i c   p a r a m e t e r   t y p e s   i n s t e a d   o f   r e p o r t i n g   c o e r c i o n   e r r o r )   	 r a n d o m   n u m b e r   f r o m   ( J a n u a r y   a s   i n t e g e r )   t o   ( D e c e m b e r   a s   i n t e g e r )   - - >   1 - 1 2 
 	 
 	 ( C a v e a t :   s e e   a b o v e   a b o u t   n o t   r e j e c t i n g   A S O C   o b j e c t s .   W i l l   n e e d   t o   b e   c a r e f u l   t o   a l l o w   N S N u m b e r / N S S t r i n g ,   t h o u g h   n o t   N S A p p l e E v e n t D e s c r i p t o r ) 
 
   -   ` m i s s i n g   v a l u e `   a n d   o t h e r   t y p e / c o n s t a n t   s y m b o l s   a r e   c u r r e n t l y   a c c e p t e d   b y   a s T e x t P a r a m e t e r   ( t h o u g h   m a y   c o e r c e   t o   e i t h e r   k e y w o r d   n a m e   t e x t   o r   r a w   c h e v r o n   t e x t ,   w h i c h   m a y   b e   a   r e a s o n   f o r   ` a s T e x t P a r a m e t e r `   t o   d i s a l l o w   t h e m ;   s e e   a l s o   h a n d l i n g   o f   m o n t h   a n d   w e e k d a y   c o n s t a n t s   i n   ` a s I n t e g e r / R e a l / N u m b e r P a r a m e t e r ` )   s o   w i l l   n o t   t r i g g e r   - 1 7 0 3 ;   s c r i p t   o b j e c t s ,   a p p   r e f s ,   e t c .   w i l l   t r i g g e r   - 1 7 0 8   d u e   t o   d i r e c t   p a r a m e t e r   d i s p a t c h   ( i . e .   ` u p p e r c a s e   t e x t `   g e t s   d i s p a t c h e d   t o   t h e m   i n s t e a d   o f   T e x t L i b )    
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��    9 3 check if a handler exists before trying to call it     �   f   c h e c k   i f   a   h a n d l e r   e x i s t s   b e f o r e   t r y i n g   t o   c a l l   i t      l     ��������  ��  ��       !   l     �� " #��   "VP used to check for the existence of an optional 'callback' handler before calling it, as AS doesn't distinguish between an error -1708 that occurs because handler wasn't defined (in which case don't call it) and an error -1708 that occurs because the handler was found but went on to call another handler that doesn't exist (i.e. a bug)    # � $ $�   u s e d   t o   c h e c k   f o r   t h e   e x i s t e n c e   o f   a n   o p t i o n a l   ' c a l l b a c k '   h a n d l e r   b e f o r e   c a l l i n g   i t ,   a s   A S   d o e s n ' t   d i s t i n g u i s h   b e t w e e n   a n   e r r o r   - 1 7 0 8   t h a t   o c c u r s   b e c a u s e   h a n d l e r   w a s n ' t   d e f i n e d   ( i n   w h i c h   c a s e   d o n ' t   c a l l   i t )   a n d   a n   e r r o r   - 1 7 0 8   t h a t   o c c u r s   b e c a u s e   t h e   h a n d l e r   w a s   f o u n d   b u t   w e n t   o n   t o   c a l l   a n o t h e r   h a n d l e r   t h a t   d o e s n ' t   e x i s t   ( i . e .   a   b u g ) !  % & % l     ��������  ��  ��   &  ' ( ' l     �� ) *��   )93 CAUTION: `hasHander` relies on AS handlers' partial ability to behave as AS objects in that they can be retrieved by name, assigned to variables, and coerced to `handler` type. Be aware, however, this object-like behavior is undocumented and essentially undefined: AS handlers are not closures, so moving them around will completely break their lexical and dynamic bindings, causing seriously bizarre and incorrect behavior if subsequently called. The only reason `hasHandler` resorts to such hackery because AS lacks the introspection/stack trace capabilites to do the job right (either by asking the containing script object to describe its contents, or by calling the handler speculatively then examining the stack trace to determine if error -1708 was due to the handler not existing or a bug occurring within it).    * � + +f   C A U T I O N :   ` h a s H a n d e r `   r e l i e s   o n   A S   h a n d l e r s '   p a r t i a l   a b i l i t y   t o   b e h a v e   a s   A S   o b j e c t s   i n   t h a t   t h e y   c a n   b e   r e t r i e v e d   b y   n a m e ,   a s s i g n e d   t o   v a r i a b l e s ,   a n d   c o e r c e d   t o   ` h a n d l e r `   t y p e .   B e   a w a r e ,   h o w e v e r ,   t h i s   o b j e c t - l i k e   b e h a v i o r   i s   u n d o c u m e n t e d   a n d   e s s e n t i a l l y   u n d e f i n e d :   A S   h a n d l e r s   a r e   n o t   c l o s u r e s ,   s o   m o v i n g   t h e m   a r o u n d   w i l l   c o m p l e t e l y   b r e a k   t h e i r   l e x i c a l   a n d   d y n a m i c   b i n d i n g s ,   c a u s i n g   s e r i o u s l y   b i z a r r e   a n d   i n c o r r e c t   b e h a v i o r   i f   s u b s e q u e n t l y   c a l l e d .   T h e   o n l y   r e a s o n   ` h a s H a n d l e r `   r e s o r t s   t o   s u c h   h a c k e r y   b e c a u s e   A S   l a c k s   t h e   i n t r o s p e c t i o n / s t a c k   t r a c e   c a p a b i l i t e s   t o   d o   t h e   j o b   r i g h t   ( e i t h e r   b y   a s k i n g   t h e   c o n t a i n i n g   s c r i p t   o b j e c t   t o   d e s c r i b e   i t s   c o n t e n t s ,   o r   b y   c a l l i n g   t h e   h a n d l e r   s p e c u l a t i v e l y   t h e n   e x a m i n i n g   t h e   s t a c k   t r a c e   t o   d e t e r m i n e   i f   e r r o r   - 1 7 0 8   w a s   d u e   t o   t h e   h a n d l e r   n o t   e x i s t i n g   o r   a   b u g   o c c u r r i n g   w i t h i n   i t ) . (  , - , l     ��������  ��  ��   -  . / . l     �� 0 1��   0 � � CAUTION: `hasHandler` only works for handlers with identifier-based names; do not use to check for existence of handlers with keyword-based names as that will result in incorrect behavior.    1 � 2 2z   C A U T I O N :   ` h a s H a n d l e r `   o n l y   w o r k s   f o r   h a n d l e r s   w i t h   i d e n t i f i e r - b a s e d   n a m e s ;   d o   n o t   u s e   t o   c h e c k   f o r   e x i s t e n c e   o f   h a n d l e r s   w i t h   k e y w o r d - b a s e d   n a m e s   a s   t h a t   w i l l   r e s u l t   i n   i n c o r r e c t   b e h a v i o r . /  3 4 3 l     ��������  ��  ��   4  5 6 5 i    7 8 7 I      �� 9���� 0 
hashandler 
hasHandler 9  :�� : o      ���� 0 
handlerref 
handlerRef��  ��   8 l     ; < = ; Q      > ? @ > l   	 A B C A k    	 D D  E F E l    G H I G c     J K J o    ���� 0 
handlerref 
handlerRef K m    ��
�� 
hand H ? 9 dereference and type check; this raises -1700 on failure    I � L L r   d e r e f e r e n c e   a n d   t y p e   c h e c k ;   t h i s   r a i s e s   - 1 7 0 0   o n   f a i l u r e F  M�� M L    	 N N m    ��
�� boovtrue��   B G A horrible hack to check if a script object has a specific handler    C � O O �   h o r r i b l e   h a c k   t o   c h e c k   i f   a   s c r i p t   o b j e c t   h a s   a   s p e c i f i c   h a n d l e r ? R      ���� P
�� .ascrerr ****      � ****��   P �� Q��
�� 
errn Q d       R R m      �������   @ l    S T U S L     V V m    ��
�� boovfals T K E the referred-to script object slot doesn't exist, or isn't a handler    U � W W �   t h e   r e f e r r e d - t o   s c r i p t   o b j e c t   s l o t   d o e s n ' t   e x i s t ,   o r   i s n ' t   a   h a n d l e r < < 6 handlerRef must be `a reference to HANDLER of SCRIPT`    = � X X l   h a n d l e r R e f   m u s t   b e   ` a   r e f e r e n c e   t o   H A N D L E R   o f   S C R I P T ` 6  Y Z Y l     ��������  ��  ��   Z  [ \ [ l     ��������  ��  ��   \  ] ^ ] l     �� _ `��   _ J D--------------------------------------------------------------------    ` � a a � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ^  b c b l     �� d e��   d � � convenience handlers for raising common errors; using these improves consistency, ensuring all error messages and parameters follow same general structure, and that all library handlers automatically benefit from any future improvements made here    e � f f�   c o n v e n i e n c e   h a n d l e r s   f o r   r a i s i n g   c o m m o n   e r r o r s ;   u s i n g   t h e s e   i m p r o v e s   c o n s i s t e n c y ,   e n s u r i n g   a l l   e r r o r   m e s s a g e s   a n d   p a r a m e t e r s   f o l l o w   s a m e   g e n e r a l   s t r u c t u r e ,   a n d   t h a t   a l l   l i b r a r y   h a n d l e r s   a u t o m a t i c a l l y   b e n e f i t   f r o m   a n y   f u t u r e   i m p r o v e m e n t s   m a d e   h e r e c  g h g l     ��������  ��  ��   h  i j i i    k l k I      �� m���� 60 throwinvalidparametertype throwInvalidParameterType m  n o n o      ���� 0 thevalue theValue o  p q p o      ���� 0 parametername parameterName q  r s r o      ���� $0 expectedtypename expectedTypeName s  t�� t o      ���� 0 expectedtype expectedType��  ��   l k     ^ u u  v w v Z      x y�� z x =      { | { n     } ~ } 1    ��
�� 
leng ~ o     ���� 0 parametername parameterName | m    ����   y r      �  m    	 � � � � �  d i r e c t � o      ���� 0 parametername parameterName��   z r     � � � b     � � � b     � � � m     � � � � �   � o    ���� 0 parametername parameterName � m     � � � � �   � o      ���� 0 parametername parameterName w  � � � Q    ? � � � � Z    4 � ��� � � >    $ � � � l   " ����� � I   "�� � �
�� .corecnte****       **** � J     � �  ��� � o    ���� 0 thevalue theValue��   � �� ���
�� 
kocl � m    ��
�� 
obj ��  ��  ��   � m   " #����   � r   ' * � � � m   ' ( � � � � � .   b u t   r e c e i v e d   s p e c i f i e r � o      ����  0 actualtypename actualTypeName��   � l  - 4 � � � � r   - 4 � � � b   - 2 � � � m   - . � � � � �    b u t   r e c e i v e d   � l  . 1 ����� � n  . 1 � � � m   / 1��
�� 
pcls � o   . /���� 0 thevalue theValue��  ��   � o      ����  0 actualtypename actualTypeName � include the value's type name in error message; note: this will display as raw four-char code when terminology isn't available, or may be a custom value in the case of records and scripts, but this can't be helped as it's a limitation of AppleScript itself    � � � �   i n c l u d e   t h e   v a l u e ' s   t y p e   n a m e   i n   e r r o r   m e s s a g e ;   n o t e :   t h i s   w i l l   d i s p l a y   a s   r a w   f o u r - c h a r   c o d e   w h e n   t e r m i n o l o g y   i s n ' t   a v a i l a b l e ,   o r   m a y   b e   a   c u s t o m   v a l u e   i n   t h e   c a s e   o f   r e c o r d s   a n d   s c r i p t s ,   b u t   t h i s   c a n ' t   b e   h e l p e d   a s   i t ' s   a   l i m i t a t i o n   o f   A p p l e S c r i p t   i t s e l f � R      ������
�� .ascrerr ****      � ****��  ��   � r   < ? � � � m   < = � � � � �   � o      ����  0 actualtypename actualTypeName �  ��� � R   @ ^�� � �
�� .ascrerr ****      � **** � b   L ] � � � b   L Y � � � b   L W � � � b   L U � � � b   L Q � � � m   L O � � � � �  I n v a l i d   � o   O P���� 0 parametername parameterName � m   Q T � � � � � *   p a r a m e t e r   ( e x p e c t e d   � o   U V���� $0 expectedtypename expectedTypeName � o   W X����  0 actualtypename actualTypeName � m   Y \ � � � � �  ) . � �� � �
�� 
errn � m   B C�����Y � �� � �
�� 
erob � o   D E���� 0 thevalue theValue � �� ���
�� 
errt � o   H I���� 0 expectedtype expectedType��  ��   j  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i    � � � I      �� ����� >0 throwinvalidparameterconstant throwInvalidParameterConstant �  � � � o      ���� 0 thevalue theValue �  ��� � o      ���� 0 parametername parameterName��  ��   � k     $ � �  � � � Z      � ��� � � =      � � � n     � � � 1    ��
�� 
leng � o     ���� 0 parametername parameterName � m    ����   � r     � � � m    	 � � � � �  d i r e c t � o      ���� 0 parametername parameterName��   � r     � � � b     � � � b     � � � m     � � � � �   � o    ���� 0 parametername parameterName � m     � � � � �   � o      ���� 0 parametername parameterName �  ��� � R    $�� � �
�� .ascrerr ****      � **** � b    # � � � b    ! � � � m     � � � � �  I n v a l i d   � o     ���� 0 parametername parameterName � m   ! " � � � � � J   p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) . � �� � �
�� 
errn � m    �����Y � �� � �
�� 
erob � o    ���� 0 thevalue theValue � �� ���
�� 
errt � m    ��
�� 
enum��  ��   �  � � � l     ����~��  �  �~   �    l     �}�|�{�}  �|  �{    i    I      �z�y�z 0 rethrowerror rethrowError  o      �x�x 0 libraryname libraryName 	
	 o      �w�w 0 handlername handlerName
  o      �v�v 0 etext eText  o      �u�u 0 enumber eNumber  o      �t�t 0 efrom eFrom  o      �s�s 
0 eto eTo  o      �r�r $0 targetobjectname targetObjectName �q o      �p�p 0 partialresult partialResult�q  �y   l    = k     =  r      b     	 b      !  b     "#" b     $%$ o     �o�o 0 libraryname libraryName% m    && �''    c a n  t  # o    �n�n 0 handlername handlerName! m    (( �))  :   o    �m�m 0 etext eText o      �l�l 0 etext eText *+* Z   ,-�k�j, >   ./. o    �i�i $0 targetobjectname targetObjectName/ m    �h
�h 
msng- r    010 b    232 b    454 o    �g�g $0 targetobjectname targetObjectName5 m    66 �77    o f  3 o    �f�f 0 etext eText1 o      �e�e 0 etext eText�k  �j  + 8�d8 Z    =9:�c;9 =   !<=< o    �b�b 0 partialresult partialResult= m     �a
�a 
msng: R   $ .�`>?
�` .ascrerr ****      � ****> o   , -�_�_ 0 etext eText? �^@A
�^ 
errn@ o   & '�]�] 0 enumber eNumberA �\BC
�\ 
erobB o   ( )�[�[ 0 efrom eFromC �ZD�Y
�Z 
errtD o   * +�X�X 
0 eto eTo�Y  �c  ; R   1 =�WEF
�W .ascrerr ****      � ****E o   ; <�V�V 0 etext eTextF �UGH
�U 
errnG o   3 4�T�T 0 enumber eNumberH �SIJ
�S 
erobI o   5 6�R�R 0 efrom eFromJ �QKL
�Q 
errtK o   7 8�P�P 
0 eto eToL �OM�N
�O 
ptlrM o   9 :�M�M 0 partialresult partialResult�N  �d   ~ x targetObjectName and partialResult should be `missing value` if unused; if eTo is unused, AS seems to be to pass `item`    �NN �   t a r g e t O b j e c t N a m e   a n d   p a r t i a l R e s u l t   s h o u l d   b e   ` m i s s i n g   v a l u e `   i f   u n u s e d ;   i f   e T o   i s   u n u s e d ,   A S   s e e m s   t o   b e   t o   p a s s   ` i t e m ` OPO l     �L�K�J�L  �K  �J  P QRQ l     �I�H�G�I  �H  �G  R STS l     �FUV�F  U � � convenience shortcuts for rethrowError() when targetObjectName and/or partialResult parameters aren't used (since AS handlers don't support optional parameters unless SDEFs are used, which only creates more complexity and challenges)   V �WW�   c o n v e n i e n c e   s h o r t c u t s   f o r   r e t h r o w E r r o r ( )   w h e n   t a r g e t O b j e c t N a m e   a n d / o r   p a r t i a l R e s u l t   p a r a m e t e r s   a r e n ' t   u s e d   ( s i n c e   A S   h a n d l e r s   d o n ' t   s u p p o r t   o p t i o n a l   p a r a m e t e r s   u n l e s s   S D E F s   a r e   u s e d ,   w h i c h   o n l y   c r e a t e s   m o r e   c o m p l e x i t y   a n d   c h a l l e n g e s )T XYX l     �E�D�C�E  �D  �C  Y Z[Z i   \]\ I      �B^�A�B &0 throwcommanderror throwCommandError^ _`_ o      �@�@ 0 libraryname libraryName` aba o      �?�? 0 handlername handlerNameb cdc o      �>�> 0 etext eTextd efe o      �=�= 0 enumber eNumberf ghg o      �<�< 0 efrom eFromh i�;i o      �:�: 
0 eto eTo�;  �A  ] R     �9j�8
�9 .ascrerr ****      � ****j I    �7k�6�7 0 rethrowerror rethrowErrork lml o    �5�5 0 libraryname libraryNamem non o    �4�4 0 handlername handlerNameo pqp o    �3�3 0 etext eTextq rsr o    �2�2 0 enumber eNumbers tut o    �1�1 0 efrom eFromu vwv o    	�0�0 
0 eto eTow xyx m   	 
�/
�/ 
msngy z�.z m   
 �-
�- 
msng�.  �6  �8  [ {|{ l     �,�+�*�,  �+  �*  | }~} l     �)�(�'�)  �(  �'  ~ � i   "��� I      �&��%�& $0 throwmethoderror throwMethodError� ��� o      �$�$ 0 libraryname libraryName� ��� o      �#�# $0 targetobjectname targetObjectName� ��� o      �"�" 0 handlername handlerName� ��� o      �!�! 0 etext eText� ��� o      � �  0 enumber eNumber� ��� o      �� 0 efrom eFrom� ��� o      �� 
0 eto eTo�  �%  � R     ���
� .ascrerr ****      � ****� I    ���� 0 rethrowerror rethrowError� ��� o    �� 0 libraryname libraryName� ��� o    �� 0 handlername handlerName� ��� o    �� 0 etext eText� ��� o    �� 0 enumber eNumber� ��� o    �� 0 efrom eFrom� ��� o    	�� 
0 eto eTo� ��� o   	 
�� $0 targetobjectname targetObjectName� ��� m   
 �
� 
msng�  �  �  � ��� l     ����  �  �  � ��� l     ���
�  �  �
  � ��� l     �	���	  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ����  �rl convenience handlers for coercing parameters to commonly-used AppleScript types, throwing a descriptive error if the coercion fails; use these to ensure parameters to library handlers are of the correct type (while AS handlers allow parameters to be directly annotated with `as TYPE` clauses, these are limited in capability and do not produce descriptive errors)   � ����   c o n v e n i e n c e   h a n d l e r s   f o r   c o e r c i n g   p a r a m e t e r s   t o   c o m m o n l y - u s e d   A p p l e S c r i p t   t y p e s ,   t h r o w i n g   a   d e s c r i p t i v e   e r r o r   i f   t h e   c o e r c i o n   f a i l s ;   u s e   t h e s e   t o   e n s u r e   p a r a m e t e r s   t o   l i b r a r y   h a n d l e r s   a r e   o f   t h e   c o r r e c t   t y p e   ( w h i l e   A S   h a n d l e r s   a l l o w   p a r a m e t e r s   t o   b e   d i r e c t l y   a n n o t a t e d   w i t h   ` a s   T Y P E `   c l a u s e s ,   t h e s e   a r e   l i m i t e d   i n   c a p a b i l i t y   a n d   d o   n o t   p r o d u c e   d e s c r i p t i v e   e r r o r s )� ��� l     ����  �  �  � ��� l     ����  � � � note: AS requires `as` operator's RH operand to be literal type name, so can't be parameterized; instead, a separate as...Parameter() handler must be defined for each type (tedious, but only needs done once)   � ����   n o t e :   A S   r e q u i r e s   ` a s `   o p e r a t o r ' s   R H   o p e r a n d   t o   b e   l i t e r a l   t y p e   n a m e ,   s o   c a n ' t   b e   p a r a m e t e r i z e d ;   i n s t e a d ,   a   s e p a r a t e   a s . . . P a r a m e t e r ( )   h a n d l e r   m u s t   b e   d e f i n e d   f o r   e a c h   t y p e   ( t e d i o u s ,   b u t   o n l y   n e e d s   d o n e   o n c e )� ��� l     ����  �  �  � ��� i  # &��� I      � ����  (0 asbooleanparameter asBooleanParameter� ��� o      ���� 0 thevalue theValue� ���� o      ���� 0 parametername parameterName��  ��  � Q     ���� L    �� c    ��� o    ���� 0 thevalue theValue� m    ��
�� 
bool� R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � I    ������� 60 throwinvalidparametertype throwInvalidParameterType� ��� o    ���� 0 thevalue theValue� ��� o    ���� 0 parametername parameterName� ��� m    �� ���  b o o l e a n� ���� m    ��
�� 
bool��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  ' *��� I      ������� (0 asintegerparameter asIntegerParameter� ��� o      ���� 0 thevalue theValue� ���� o      ���� 0 parametername parameterName��  ��  � Q     ���� l   ���� L    �� c    ��� o    ���� 0 thevalue theValue� m    ��
�� 
long� { u TO DO: error if theValue has non-zero fractional part? (AS rounds toward zero by default, i.e. discarding user data)   � ��� �   T O   D O :   e r r o r   i f   t h e V a l u e   h a s   n o n - z e r o   f r a c t i o n a l   p a r t ?   ( A S   r o u n d s   t o w a r d   z e r o   b y   d e f a u l t ,   i . e .   d i s c a r d i n g   u s e r   d a t a )� R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � I    ������� 60 throwinvalidparametertype throwInvalidParameterType� ��� o    ���� 0 thevalue theValue� ��� o    ���� 0 parametername parameterName� ��� m    �� ���  i n t e g e r� ���� m    ��
�� 
long��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  + .��� I      ������� "0 asrealparameter asRealParameter�    o      ���� 0 thevalue theValue �� o      ���� 0 parametername parameterName��  ��  � Q      L     c     o    ���� 0 thevalue theValue m    ��
�� 
doub R      ����	
�� .ascrerr ****      � ****��  	 ��
��
�� 
errn
 d       m      �������   I    ������ 60 throwinvalidparametertype throwInvalidParameterType  o    ���� 0 thevalue theValue  o    ���� 0 parametername parameterName  m     �  r e a l �� m    ��
�� 
doub��  ��  �  l     ��������  ��  ��    l     ��������  ��  ��    i  / 2 I      ������ &0 asnumberparameter asNumberParameter   o      ���� 0 thevalue theValue  !��! o      ���� 0 parametername parameterName��  ��   Q     "#$" L    %% c    &'& o    ���� 0 thevalue theValue' m    ��
�� 
nmbr# R      ����(
�� .ascrerr ****      � ****��  ( ��)��
�� 
errn) d      ** m      �������  $ I    ��+���� 60 throwinvalidparametertype throwInvalidParameterType+ ,-, o    ���� 0 thevalue theValue- ./. o    ���� 0 parametername parameterName/ 010 m    22 �33  n u m b e r1 4��4 m    ��
�� 
nmbr��  ��   565 l     ��������  ��  ��  6 787 l     ��������  ��  ��  8 9:9 i  3 6;<; I      ��=���� "0 astextparameter asTextParameter= >?> o      ���� 0 thevalue theValue? @��@ o      ���� 0 parametername parameterName��  ��  < Q     ABCA L    DD c    EFE o    ���� 0 thevalue theValueF m    ��
�� 
ctxtB R      ����G
�� .ascrerr ****      � ****��  G ��H��
�� 
errnH d      II m      �������  C I    ��J���� 60 throwinvalidparametertype throwInvalidParameterTypeJ KLK o    ���� 0 thevalue theValueL MNM o    ���� 0 parametername parameterNameN OPO m    QQ �RR  t e x tP S��S m    ��
�� 
ctxt��  ��  : TUT l     ��������  ��  ��  U VWV l     ��������  ��  ��  W XYX i  7 :Z[Z I      ��\���� "0 asdateparameter asDateParameter\ ]^] o      ���� 0 thevalue theValue^ _��_ o      ���� 0 parametername parameterName��  ��  [ Q     `ab` l   cdec L    ff c    ghg o    ���� 0 thevalue theValueh m    ��
�� 
ldt d 7 1 TO DO: if theValue is text, use `date theValue`?   e �ii b   T O   D O :   i f   t h e V a l u e   i s   t e x t ,   u s e   ` d a t e   t h e V a l u e ` ?a R      ����j
�� .ascrerr ****      � ****��  j �k�~
� 
errnk d      ll m      �}�}��~  b I    �|m�{�| 60 throwinvalidparametertype throwInvalidParameterTypem non o    �z�z 0 thevalue theValueo pqp o    �y�y 0 parametername parameterNameq rsr m    tt �uu  d a t es v�xv m    �w
�w 
ldt �x  �{  Y wxw l     �v�u�t�v  �u  �t  x yzy l     �s�r�q�s  �r  �q  z {|{ i  ; >}~} I      �p�o�p "0 aslistparameter asListParameter ��n� o      �m�m 0 thevalue theValue�n  �o  ~ k     �� ��� l     �l���l  �ic a more robust alternative to `theValue as list` that handles records correctly, e.g. `asListParameter({a:1,b:2})` returns `{{a:1,b:2}}` instead of `{1,2}` (AS's record-to-list coercion handler stupidly strips the record's keys, returning just its values, whereas its other TYPE-to-list coercion handlers simply wrap non-list values as a single-item list)   � ����   a   m o r e   r o b u s t   a l t e r n a t i v e   t o   ` t h e V a l u e   a s   l i s t `   t h a t   h a n d l e s   r e c o r d s   c o r r e c t l y ,   e . g .   ` a s L i s t P a r a m e t e r ( { a : 1 , b : 2 } ) `   r e t u r n s   ` { { a : 1 , b : 2 } } `   i n s t e a d   o f   ` { 1 , 2 } `   ( A S ' s   r e c o r d - t o - l i s t   c o e r c i o n   h a n d l e r   s t u p i d l y   s t r i p s   t h e   r e c o r d ' s   k e y s ,   r e t u r n i n g   j u s t   i t s   v a l u e s ,   w h e r e a s   i t s   o t h e r   T Y P E - t o - l i s t   c o e r c i o n   h a n d l e r s   s i m p l y   w r a p   n o n - l i s t   v a l u e s   a s   a   s i n g l e - i t e m   l i s t )� ��� l     �k���k  � � � note that unlike other as...Parameter handlers this doesn't take a parameterName parameter as it should never fail as *any* value can be successfully converted to a one-item list   � ���f   n o t e   t h a t   u n l i k e   o t h e r   a s . . . P a r a m e t e r   h a n d l e r s   t h i s   d o e s n ' t   t a k e   a   p a r a m e t e r N a m e   p a r a m e t e r   a s   i t   s h o u l d   n e v e r   f a i l   a s   * a n y *   v a l u e   c a n   b e   s u c c e s s f u l l y   c o n v e r t e d   t o   a   o n e - i t e m   l i s t� ��� l     �j���j  �
 caution: if the value is a list, it is returned as-is; handlers should not modify user-supplied lists in-place (unless that is an explicitly documented feature), but instead shallow copy it when needed, e.g. `set theListCopy to items of asListParameter(theList,"")`   � ���   c a u t i o n :   i f   t h e   v a l u e   i s   a   l i s t ,   i t   i s   r e t u r n e d   a s - i s ;   h a n d l e r s   s h o u l d   n o t   m o d i f y   u s e r - s u p p l i e d   l i s t s   i n - p l a c e   ( u n l e s s   t h a t   i s   a n   e x p l i c i t l y   d o c u m e n t e d   f e a t u r e ) ,   b u t   i n s t e a d   s h a l l o w   c o p y   i t   w h e n   n e e d e d ,   e . g .   ` s e t   t h e L i s t C o p y   t o   i t e m s   o f   a s L i s t P a r a m e t e r ( t h e L i s t , " " ) `� ��i� Z     ���h�� =     ��� l    	��g�f� I    	�e��
�e .corecnte****       ****� J     �� ��d� o     �c�c 0 thevalue theValue�d  � �b��a
�b 
kocl� m    �`
�` 
list�a  �g  �f  � m   	 
�_�_  � L    �� J    �� ��^� o    �]�] 0 thevalue theValue�^  �h  � L    �� o    �\�\ 0 thevalue theValue�i  | ��� l     �[�Z�Y�[  �Z  �Y  � ��� l     �X�W�V�X  �W  �V  � ��� i  ? B��� I      �U��T�U &0 asrecordparameter asRecordParameter� ��� o      �S�S 0 thevalue theValue� ��R� o      �Q�Q 0 parametername parameterName�R  �T  � k     �� ��� l      �P���P  �& 
TO DO: variant of this that also accepts defaultRecord parameter, merging the two and checking for any missing properties; Q. how to indicate/check non-optional properties? one option would be to pass a record containing all of the optional properties (with default values) plus a record of non-optional properties (with type classes/error messages/placeholders? - basically, something that ASOC can introspect for error message generation, although there are question marks over the efficiency of sending the user-supplied record over the ASOC bridge just to determine its keys, plus the usual issues regarding keyword-based keys vs identifier-based keys)

e.g. from TestLib's SupportLib (although this makes some case-specific assumptions that won't work for a general-purpose solution):

to normalizeExpectedErrorRecord(errorRecord) -- ensure error info record has all the correct properties and that at least one of them is populated	-- make sure errorRecord contains at least one valid property and no invalid ones (note: this uses NoValue placeholders so isn't suitable for sending out of current AS instance)	if errorRecord's length = 0 then error "Invalid �is� parameter (error record contained no properties)." number -1703 from errorRecord to record	set normalizedRecord to errorRecord & _defaultErrorRecord	if normalizedRecord's length � _defaultErrorRecord's length then error "Invalid �is� parameter (error record contained unrecognized properties)." number -1703 from errorRecord to record	return normalizedRecordend normalizeExpectedErrorRecord
   � ���@ 
 T O   D O :   v a r i a n t   o f   t h i s   t h a t   a l s o   a c c e p t s   d e f a u l t R e c o r d   p a r a m e t e r ,   m e r g i n g   t h e   t w o   a n d   c h e c k i n g   f o r   a n y   m i s s i n g   p r o p e r t i e s ;   Q .   h o w   t o   i n d i c a t e / c h e c k   n o n - o p t i o n a l   p r o p e r t i e s ?   o n e   o p t i o n   w o u l d   b e   t o   p a s s   a   r e c o r d   c o n t a i n i n g   a l l   o f   t h e   o p t i o n a l   p r o p e r t i e s   ( w i t h   d e f a u l t   v a l u e s )   p l u s   a   r e c o r d   o f   n o n - o p t i o n a l   p r o p e r t i e s   ( w i t h   t y p e   c l a s s e s / e r r o r   m e s s a g e s / p l a c e h o l d e r s ?   -   b a s i c a l l y ,   s o m e t h i n g   t h a t   A S O C   c a n   i n t r o s p e c t   f o r   e r r o r   m e s s a g e   g e n e r a t i o n ,   a l t h o u g h   t h e r e   a r e   q u e s t i o n   m a r k s   o v e r   t h e   e f f i c i e n c y   o f   s e n d i n g   t h e   u s e r - s u p p l i e d   r e c o r d   o v e r   t h e   A S O C   b r i d g e   j u s t   t o   d e t e r m i n e   i t s   k e y s ,   p l u s   t h e   u s u a l   i s s u e s   r e g a r d i n g   k e y w o r d - b a s e d   k e y s   v s   i d e n t i f i e r - b a s e d   k e y s ) 
 
 e . g .   f r o m   T e s t L i b ' s   S u p p o r t L i b   ( a l t h o u g h   t h i s   m a k e s   s o m e   c a s e - s p e c i f i c   a s s u m p t i o n s   t h a t   w o n ' t   w o r k   f o r   a   g e n e r a l - p u r p o s e   s o l u t i o n ) : 
 
 t o   n o r m a l i z e E x p e c t e d E r r o r R e c o r d ( e r r o r R e c o r d )   - -   e n s u r e   e r r o r   i n f o   r e c o r d   h a s   a l l   t h e   c o r r e c t   p r o p e r t i e s   a n d   t h a t   a t   l e a s t   o n e   o f   t h e m   i s   p o p u l a t e d  	 - -   m a k e   s u r e   e r r o r R e c o r d   c o n t a i n s   a t   l e a s t   o n e   v a l i d   p r o p e r t y   a n d   n o   i n v a l i d   o n e s   ( n o t e :   t h i s   u s e s   N o V a l u e   p l a c e h o l d e r s   s o   i s n ' t   s u i t a b l e   f o r   s e n d i n g   o u t   o f   c u r r e n t   A S   i n s t a n c e )  	 i f   e r r o r R e c o r d ' s   l e n g t h   =   0   t h e n   e r r o r   " I n v a l i d    i s    p a r a m e t e r   ( e r r o r   r e c o r d   c o n t a i n e d   n o   p r o p e r t i e s ) . "   n u m b e r   - 1 7 0 3   f r o m   e r r o r R e c o r d   t o   r e c o r d  	 s e t   n o r m a l i z e d R e c o r d   t o   e r r o r R e c o r d   &   _ d e f a u l t E r r o r R e c o r d  	 i f   n o r m a l i z e d R e c o r d ' s   l e n g t h  "`   _ d e f a u l t E r r o r R e c o r d ' s   l e n g t h   t h e n   e r r o r   " I n v a l i d    i s    p a r a m e t e r   ( e r r o r   r e c o r d   c o n t a i n e d   u n r e c o g n i z e d   p r o p e r t i e s ) . "   n u m b e r   - 1 7 0 3   f r o m   e r r o r R e c o r d   t o   r e c o r d  	 r e t u r n   n o r m a l i z e d R e c o r d  e n d   n o r m a l i z e E x p e c t e d E r r o r R e c o r d  
� ��O� Q     ���� L    �� c    ��� o    �N�N 0 thevalue theValue� m    �M
�M 
reco� R      �L�K�
�L .ascrerr ****      � ****�K  � �J��I
�J 
errn� d      �� m      �H�H��I  � I    �G��F�G 60 throwinvalidparametertype throwInvalidParameterType� ��� o    �E�E 0 thevalue theValue� ��� o    �D�D 0 parametername parameterName� ��� m    �� ���  r e c o r d� ��C� m    �B
�B 
reco�C  �F  �O  � ��� l     �A�@�?�A  �@  �?  � ��� l     �>�=�<�>  �=  �<  � ��� i  C F��� I      �;��:�; &0 asscriptparameter asScriptParameter� ��� o      �9�9 0 thevalue theValue� ��8� o      �7�7 0 parametername parameterName�8  �:  � Q     ���� L    �� c    ��� o    �6�6 0 thevalue theValue� m    �5
�5 
scpt� R      �4�3�
�4 .ascrerr ****      � ****�3  � �2��1
�2 
errn� d      �� m      �0�0��1  � I    �/��.�/ 60 throwinvalidparametertype throwInvalidParameterType� ��� o    �-�- 0 thevalue theValue� ��� o    �,�, 0 parametername parameterName� ��� m    �� ���  s c r i p t� ��+� m    �*
�* 
scpt�+  �.  � ��� l     �)�(�'�)  �(  �'  � ��� l     �&�%�$�&  �%  �$  � ��� i  G J��� I      �#��"�# "0 astypeparameter asTypeParameter� ��� o      �!�! 0 thevalue theValue� �� � o      �� 0 parametername parameterName�   �"  � Q     ���� L    �� c    ��� o    �� 0 thevalue theValue� m    �
� 
type� R      ���
� .ascrerr ****      � ****�  � ���
� 
errn� d      �� m      ����  � I    ���� 60 throwinvalidparametertype throwInvalidParameterType� ��� o    �� 0 thevalue theValue� ��� o    �� 0 parametername parameterName�    m     �  t y p e � m    �
� 
type�  �  �  l     ����  �  �    l     ����  �  �   	
	 i  K N I      ��
� ,0 asposixpathparameter asPOSIXPathParameter  o      �	�	 0 thevalue theValue � o      �� 0 parametername parameterName�  �
   l    . Z     .� >      l    	�� I    	�
� .corecnte****       **** J      � o     �� 0 thevalue theValue�   � ��
�  
kocl m    ��
�� 
ctxt��  �  �   m   	 
����   l    ! L    "" o    ���� 0 thevalue theValue jd TO DO: what if any validation should be done here? (e.g. might want to check for leading slash, and/or absence of illegal chars; would running it through NSURL help?); might be best to have separate versions of this for absolute vs relative paths (e.g. `join path` accepts either, whereas `read file` probably wants absolute path) - need to think about it   ! �##�   T O   D O :   w h a t   i f   a n y   v a l i d a t i o n   s h o u l d   b e   d o n e   h e r e ?   ( e . g .   m i g h t   w a n t   t o   c h e c k   f o r   l e a d i n g   s l a s h ,   a n d / o r   a b s e n c e   o f   i l l e g a l   c h a r s ;   w o u l d   r u n n i n g   i t   t h r o u g h   N S U R L   h e l p ? ) ;   m i g h t   b e   b e s t   t o   h a v e   s e p a r a t e   v e r s i o n s   o f   t h i s   f o r   a b s o l u t e   v s   r e l a t i v e   p a t h s   ( e . g .   ` j o i n   p a t h `   a c c e p t s   e i t h e r ,   w h e r e a s   ` r e a d   f i l e `   p r o b a b l y   w a n t s   a b s o l u t e   p a t h )   -   n e e d   t o   t h i n k   a b o u t   i t�   Q    .$%&$ L    '' n    ()( 1    ��
�� 
psxp) l   *����* c    +,+ o    ���� 0 thevalue theValue, m    ��
�� 
furl��  ��  % R      ����-
�� .ascrerr ****      � ****��  - ��.��
�� 
errn. d      // m      �������  & I   % .��0���� 60 throwinvalidparametertype throwInvalidParameterType0 121 o   & '���� 0 thevalue theValue2 343 o   ' (���� 0 parametername parameterName4 565 m   ( )77 �88  P O S I X   p a t h6 9��9 m   ) *��
�� 
ctxt��  ��   � � given any of AS's various file identifier objects (alias, �class furl�, etc) or a POSIX path string, returns a POSIX path string    �::   g i v e n   a n y   o f   A S ' s   v a r i o u s   f i l e   i d e n t i f i e r   o b j e c t s   ( a l i a s ,   � c l a s s   f u r l � ,   e t c )   o r   a   P O S I X   p a t h   s t r i n g ,   r e t u r n s   a   P O S I X   p a t h   s t r i n g
 ;<; l     ��������  ��  ��  < =>= l     ��������  ��  ��  > ?@? l     ��AB��  A J D--------------------------------------------------------------------   B �CC � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -@ DED l     ��FG��  F � � convenience handlers for coercing parameters to commonly-used AppleScript-ObjC types -- TO DO: add more AS-to-ASOC handlers? also include error checking, and provide both `asNSCLASS` and `asNSCLASSParameter` variants   G �HH�   c o n v e n i e n c e   h a n d l e r s   f o r   c o e r c i n g   p a r a m e t e r s   t o   c o m m o n l y - u s e d   A p p l e S c r i p t - O b j C   t y p e s   - -   T O   D O :   a d d   m o r e   A S - t o - A S O C   h a n d l e r s ?   a l s o   i n c l u d e   e r r o r   c h e c k i n g ,   a n d   p r o v i d e   b o t h   ` a s N S C L A S S `   a n d   ` a s N S C L A S S P a r a m e t e r `   v a r i a n t sE IJI l     ��������  ��  ��  J KLK i  O RMNM I      ��O���� &0 aslocaleparameter asLocaleParameterO PQP o      ���� 0 
localecode 
localeCodeQ R��R o      ���� 0 parametername parameterName��  ��  N l    $STUS Z     $VW��XV =    YZY o     ���� 0 
localecode 
localeCodeZ m    ��
�� 
msngW l   [\][ L    ^^ n   _`_ I   	 �������� 0 systemlocale systemLocale��  ��  ` n   	aba o    	���� 0 nslocale NSLocaleb m    ��
�� misccura\ 5 / note: to specify user's current locale instead   ] �cc ^   n o t e :   t o   s p e c i f y   u s e r ' s   c u r r e n t   l o c a l e   i n s t e a d��  X k    $dd efe l   ghig r    jkj I    ��l���� "0 astextparameter asTextParameterl mnm o    ���� 0 
localecode 
localeCoden o��o o    ���� 0 parametername parameterName��  ��  k o      ���� 0 
localecode 
localeCodeh ; 5 TO DO: rejig this to return correct `expected` types   i �pp j   T O   D O :   r e j i g   t h i s   t o   r e t u r n   c o r r e c t   ` e x p e c t e d `   t y p e sf q��q l   $rstr L    $uu n   #vwv I    #��x���� :0 localewithlocaleidentifier_ localeWithLocaleIdentifier_x y��y o    ���� 0 
localecode 
localeCode��  ��  w n   z{z o    ���� 0 nslocale NSLocale{ m    ��
�� misccuras � � TO DO: error if unrecognized code (how? +localeWithLocaleIdentifier: always returns an NSLocale instance, even if code isn't recognized)   t �||   T O   D O :   e r r o r   i f   u n r e c o g n i z e d   c o d e   ( h o w ?   + l o c a l e W i t h L o c a l e I d e n t i f i e r :   a l w a y s   r e t u r n s   a n   N S L o c a l e   i n s t a n c e ,   e v e n   i f   c o d e   i s n ' t   r e c o g n i z e d )��  T * $ TO DO: rename `asNSLocaleParameter`   U �}} H   T O   D O :   r e n a m e   ` a s N S L o c a l e P a r a m e t e r `L ~~ l     ��������  ��  ��   ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��       ������������������������  � ��������������������������������������
�� 
pimr�� 0 
hashandler 
hasHandler�� 60 throwinvalidparametertype throwInvalidParameterType�� >0 throwinvalidparameterconstant throwInvalidParameterConstant�� 0 rethrowerror rethrowError�� &0 throwcommanderror throwCommandError�� $0 throwmethoderror throwMethodError�� (0 asbooleanparameter asBooleanParameter�� (0 asintegerparameter asIntegerParameter�� "0 asrealparameter asRealParameter�� &0 asnumberparameter asNumberParameter�� "0 astextparameter asTextParameter�� "0 asdateparameter asDateParameter�� "0 aslistparameter asListParameter�� &0 asrecordparameter asRecordParameter�� &0 asscriptparameter asScriptParameter�� "0 astypeparameter asTypeParameter�� ,0 asposixpathparameter asPOSIXPathParameter�� &0 aslocaleparameter asLocaleParameter� ����� �  �� �����
�� 
cobj� ��   �� 
�� 
frmk��  � �� 8���������� 0 
hashandler 
hasHandler�� ����� �  ���� 0 
handlerref 
handlerRef��  � ���� 0 
handlerref 
handlerRef� �����
�� 
hand��  � ������
�� 
errn���\��  ��  ��&OeW 	X  f� �� l���������� 60 throwinvalidparametertype throwInvalidParameterType�� ����� �  ���������� 0 thevalue theValue�� 0 parametername parameterName�� $0 expectedtypename expectedTypeName�� 0 expectedtype expectedType��  � ������������ 0 thevalue theValue�� 0 parametername parameterName�� $0 expectedtypename expectedTypeName�� 0 expectedtype expectedType��  0 actualtypename actualTypeName� �� � � ������� � ������� ���������� � � �
�� 
leng
�� 
kocl
�� 
obj 
�� .corecnte****       ****
�� 
pcls��  ��  
�� 
errn���Y
�� 
erob
�� 
errt� �� _��,j  �E�Y 	�%�%E�O  �kv��l j �E�Y 	��,%E�W 
X 
 �E�O)���a �a a �%a %�%�%a %� �~ ��}�|���{�~ >0 throwinvalidparameterconstant throwInvalidParameterConstant�} �z��z �  �y�x�y 0 thevalue theValue�x 0 parametername parameterName�|  � �w�v�w 0 thevalue theValue�v 0 parametername parameterName� �u � � ��t�s�r�q�p�o � �
�u 
leng
�t 
errn�s�Y
�r 
erob
�q 
errt
�p 
enum�o �{ %��,j  �E�Y 	�%�%E�O)�������%�%� �n�m�l���k�n 0 rethrowerror rethrowError�m �j��j �  �i�h�g�f�e�d�c�b�i 0 libraryname libraryName�h 0 handlername handlerName�g 0 etext eText�f 0 enumber eNumber�e 0 efrom eFrom�d 
0 eto eTo�c $0 targetobjectname targetObjectName�b 0 partialresult partialResult�l  � �a�`�_�^�]�\�[�Z�a 0 libraryname libraryName�` 0 handlername handlerName�_ 0 etext eText�^ 0 enumber eNumber�] 0 efrom eFrom�\ 
0 eto eTo�[ $0 targetobjectname targetObjectName�Z 0 partialresult partialResult� 
&(�Y6�X�W�V�U�T�S
�Y 
msng
�X 
errn
�W 
erob
�V 
errt�U 
�T 
ptlr�S �k >��%�%�%�%E�O�� ��%�%E�Y hO��  )����Y )������ �R]�Q�P���O�R &0 throwcommanderror throwCommandError�Q �N��N �  �M�L�K�J�I�H�M 0 libraryname libraryName�L 0 handlername handlerName�K 0 etext eText�J 0 enumber eNumber�I 0 efrom eFrom�H 
0 eto eTo�P  � �G�F�E�D�C�B�G 0 libraryname libraryName�F 0 handlername handlerName�E 0 etext eText�D 0 enumber eNumber�C 0 efrom eFrom�B 
0 eto eTo� �A�@�?
�A 
msng�@ �? 0 rethrowerror rethrowError�O )j*���������+ � �>��=�<���;�> $0 throwmethoderror throwMethodError�= �:��: �  �9�8�7�6�5�4�3�9 0 libraryname libraryName�8 $0 targetobjectname targetObjectName�7 0 handlername handlerName�6 0 etext eText�5 0 enumber eNumber�4 0 efrom eFrom�3 
0 eto eTo�<  � �2�1�0�/�.�-�,�2 0 libraryname libraryName�1 $0 targetobjectname targetObjectName�0 0 handlername handlerName�/ 0 etext eText�. 0 enumber eNumber�- 0 efrom eFrom�, 
0 eto eTo� �+�*�)
�+ 
msng�* �) 0 rethrowerror rethrowError�; )j*���������+ � �(��'�&���%�( (0 asbooleanparameter asBooleanParameter�' �$��$ �  �#�"�# 0 thevalue theValue�" 0 parametername parameterName�&  � �!� �! 0 thevalue theValue�  0 parametername parameterName� ������
� 
bool�  � ���
� 
errn��\�  � � 60 throwinvalidparametertype throwInvalidParameterType�%  	��&W X  *�����+ � �������� (0 asintegerparameter asIntegerParameter� ��� �  ��� 0 thevalue theValue� 0 parametername parameterName�  � ��� 0 thevalue theValue� 0 parametername parameterName� ������
� 
long�  � ��
�	
� 
errn�
�\�	  � � 60 throwinvalidparametertype throwInvalidParameterType�  	��&W X  *�����+ � �������� "0 asrealparameter asRealParameter� ��� �  ��� 0 thevalue theValue� 0 parametername parameterName�  � �� � 0 thevalue theValue�  0 parametername parameterName� ���������
�� 
doub��  � ������
�� 
errn���\��  �� �� 60 throwinvalidparametertype throwInvalidParameterType�  	��&W X  *�����+ � ������������ &0 asnumberparameter asNumberParameter�� ����� �  ������ 0 thevalue theValue�� 0 parametername parameterName��  � ������ 0 thevalue theValue�� 0 parametername parameterName� �����2����
�� 
nmbr��  � ������
�� 
errn���\��  �� �� 60 throwinvalidparametertype throwInvalidParameterType��  	��&W X  *�����+ � ��<���������� "0 astextparameter asTextParameter�� ����� �  ������ 0 thevalue theValue�� 0 parametername parameterName��  � ������ 0 thevalue theValue�� 0 parametername parameterName� �����Q����
�� 
ctxt��  � ������
�� 
errn���\��  �� �� 60 throwinvalidparametertype throwInvalidParameterType��  	��&W X  *�����+ � ��[���������� "0 asdateparameter asDateParameter�� ����� �  ������ 0 thevalue theValue�� 0 parametername parameterName��  � ������ 0 thevalue theValue�� 0 parametername parameterName� �����t����
�� 
ldt ��  � ������
�� 
errn���\��  �� �� 60 throwinvalidparametertype throwInvalidParameterType��  	��&W X  *�����+ � ��~���������� "0 aslistparameter asListParameter�� ����� �  ���� 0 thevalue theValue��  � ���� 0 thevalue theValue� ������
�� 
kocl
�� 
list
�� .corecnte****       ****�� �kv��l j  	�kvY �� ������������� &0 asrecordparameter asRecordParameter�� ����� �  ������ 0 thevalue theValue�� 0 parametername parameterName��  � ������ 0 thevalue theValue�� 0 parametername parameterName� ����������
�� 
reco��  � ������
�� 
errn���\��  �� �� 60 throwinvalidparametertype throwInvalidParameterType��  	��&W X  *�����+ � ������������� &0 asscriptparameter asScriptParameter�� ����� �  ������ 0 thevalue theValue�� 0 parametername parameterName��  � ������ 0 thevalue theValue�� 0 parametername parameterName� ����������
�� 
scpt��  � ������
�� 
errn���\��  �� �� 60 throwinvalidparametertype throwInvalidParameterType��  	��&W X  *�����+ � ������������� "0 astypeparameter asTypeParameter�� ����� �  ������ 0 thevalue theValue�� 0 parametername parameterName��  � ������ 0 thevalue theValue�� 0 parametername parameterName� ���������
�� 
type��  � ������
�� 
errn���\��  �� �� 60 throwinvalidparametertype throwInvalidParameterType��  	��&W X  *�����+ � ������������ ,0 asposixpathparameter asPOSIXPathParameter�� ����� �  ������ 0 thevalue theValue�� 0 parametername parameterName��  � ������ 0 thevalue theValue�� 0 parametername parameterName� 
�������������7��~
�� 
kocl
�� 
ctxt
�� .corecnte****       ****
�� 
furl
�� 
psxp��  � �}�|�{
�} 
errn�|�\�{  � �~ 60 throwinvalidparametertype throwInvalidParameterType�� /�kv��l j �Y  ��&�,EW X  *�����+ 	� �zN�y�x���w�z &0 aslocaleparameter asLocaleParameter�y �v��v �  �u�t�u 0 
localecode 
localeCode�t 0 parametername parameterName�x  � �s�r�s 0 
localecode 
localeCode�r 0 parametername parameterName� �q�p�o�n�m�l
�q 
msng
�p misccura�o 0 nslocale NSLocale�n 0 systemlocale systemLocale�m "0 astextparameter asTextParameter�l :0 localewithlocaleidentifier_ localeWithLocaleIdentifier_�w %��  ��,j+ Y *��l+ E�O��,�k+ ascr  ��ޭ