FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� TextLib -- commonly-used text processing commands

Caution: When matching text item delimiters in text value, AppleScript uses the current scope's existing considering/ignoring case, diacriticals, hyphens, punctuation, white space and numeric strings settings; thus, wrapping a `search text` command in different considering/ignoring blocks can produce different results. For example, `search text "foo" for "F" will normally match the first character since AppleScript uses case-insensitive matching by default, whereas enclosing it in a `considering case` block will cause the same command to return zero matches. Conversely, `search text "f oo" for "fo"` will normally return zero matches as AppleScript considers white space by default, but when enclosed in an `ignoring white space` block will match the first three characters. This is how AppleScript is designed to work, but users need to be reminded of this as considering/ignoring blocks affect ALL script handlers called within that block, including nested calls (and all to any osax and application handlers that understand considering/ignoring attributes).

TO DO:

- decide if predefined considering/ignoring options in `search text`, etc. should consider or ignore diacriticals and numeric strings; once decided, use same combinations for ListLib's text comparator for consistency

- also provide `exact match` option in `search text`, etc. that considers case, diacriticals, hyphens, punctuation and white space but ignores numeric strings?

- to normalize text theText using normalizationForm -- (Q. how does AS normally deal with composed vs decomposed unicode chars?) -- TO DO: use `precomposed characters` and `compatibility mapping` boolean params? (also, need to figure out which is preferred form to use as default)
		decomposedStringWithCanonicalMapping (Unicode Normalization Form D)
		decomposedStringWithCompatibilityMapping (Unicode Normalization Form KD)
		precomposedStringWithCanonicalMapping (Unicode Normalization Form C)
		precomposedStringWithCompatibilityMapping (Unicode Normalization Form KC)



- `insert into text`, `delete from text` for inserting/replacing/deleting ranges of characters (c.f. `insert into list`, `delete from list` in ListLib)


- add `matching first item only` boolean option to `search text` (this allows users to perform incremental matching fairly efficiently without having to use an Iterator API)

- option to use script object as `search text`'s `replacing with` argument? this would take a match record produced by _find...() and return the text to insert; useful when e.g. uppercasing matched text (currently user has to repeat over the list of match records returned by `search text` and replace each text range herself)

- may be worth implementing a "compare text" command that allows considering/ignoring options to be supplied as parameters (considering/ignoring blocks can't be parameterized as they require hardcoded constants) as this would allow comparisons to be safely performed without having to futz with considering/ignoring blocks all the time (c.f. MathLib's `compare number`); for extra flexibility, the comparator constructor should also be exposed as a public command, and the returned object implement the same `makeKey`+`compareItems` methods as ListLib's sort comparators, allowing them to be used interchangeably (one could even argue for putting all comparators into their own lib, which other libraries and user scripts can import whenever they need to parameterize comparison behavior)

- `pad text TEXT using CHAR to LENGTH from [start/middle/end]` -- TO DO: what to use for constants? (`beginning/middle/end of text` is no good as that masks existing reference forms); also, should this go into FormatLib? (consider also padding numbers, which is similar idea but needs to take into account [e.g.] decimal places)


- improve uppercase/lowercase implementation; from NSString.h:

/* The following three return the canonical (non-localized) mappings. They are suitable for programming operations that require stable results not depending on the user's locale preference.  For locale-aware case mapping for strings presented to users, use the "...StringWithLocale:" methods below.
*/
@property (readonly, copy) NSString *uppercaseString;
@property (readonly, copy) NSString *lowercaseString;
@property (readonly, copy) NSString *capitalizedString;

/* The following three return the locale-aware case mappings. They are suitable for strings presented to the user.
*/
@property (readonly, copy) NSString *localizedUppercaseString NS_AVAILABLE(10_11, 9_0);
@property (readonly, copy) NSString *localizedLowercaseString NS_AVAILABLE(10_11, 9_0);
@property (readonly, copy) NSString *localizedCapitalizedString NS_AVAILABLE(10_11, 9_0);

/* The following methods perform localized case mappings based on the locale specified. Passing nil indicates the canonical mapping.  For the user preference locale setting, specify +[NSLocale currentLocale].
*/
- (NSString)uppercaseStringWithLocale:(nullable NSLocale)locale NS_AVAILABLE(10_8, 6_0);
- (NSString)lowercaseStringWithLocale:(nullable NSLocale)locale NS_AVAILABLE(10_8, 6_0);
- (NSString)capitalizedStringWithLocale:(nullable NSLocale)locale NS_AVAILABLE(10_8, 6_0);

     � 	 	)   T e x t L i b   - -   c o m m o n l y - u s e d   t e x t   p r o c e s s i n g   c o m m a n d s 
 
 C a u t i o n :   W h e n   m a t c h i n g   t e x t   i t e m   d e l i m i t e r s   i n   t e x t   v a l u e ,   A p p l e S c r i p t   u s e s   t h e   c u r r e n t   s c o p e ' s   e x i s t i n g   c o n s i d e r i n g / i g n o r i n g   c a s e ,   d i a c r i t i c a l s ,   h y p h e n s ,   p u n c t u a t i o n ,   w h i t e   s p a c e   a n d   n u m e r i c   s t r i n g s   s e t t i n g s ;   t h u s ,   w r a p p i n g   a   ` s e a r c h   t e x t `   c o m m a n d   i n   d i f f e r e n t   c o n s i d e r i n g / i g n o r i n g   b l o c k s   c a n   p r o d u c e   d i f f e r e n t   r e s u l t s .   F o r   e x a m p l e ,   ` s e a r c h   t e x t   " f o o "   f o r   " F "   w i l l   n o r m a l l y   m a t c h   t h e   f i r s t   c h a r a c t e r   s i n c e   A p p l e S c r i p t   u s e s   c a s e - i n s e n s i t i v e   m a t c h i n g   b y   d e f a u l t ,   w h e r e a s   e n c l o s i n g   i t   i n   a   ` c o n s i d e r i n g   c a s e `   b l o c k   w i l l   c a u s e   t h e   s a m e   c o m m a n d   t o   r e t u r n   z e r o   m a t c h e s .   C o n v e r s e l y ,   ` s e a r c h   t e x t   " f   o o "   f o r   " f o " `   w i l l   n o r m a l l y   r e t u r n   z e r o   m a t c h e s   a s   A p p l e S c r i p t   c o n s i d e r s   w h i t e   s p a c e   b y   d e f a u l t ,   b u t   w h e n   e n c l o s e d   i n   a n   ` i g n o r i n g   w h i t e   s p a c e `   b l o c k   w i l l   m a t c h   t h e   f i r s t   t h r e e   c h a r a c t e r s .   T h i s   i s   h o w   A p p l e S c r i p t   i s   d e s i g n e d   t o   w o r k ,   b u t   u s e r s   n e e d   t o   b e   r e m i n d e d   o f   t h i s   a s   c o n s i d e r i n g / i g n o r i n g   b l o c k s   a f f e c t   A L L   s c r i p t   h a n d l e r s   c a l l e d   w i t h i n   t h a t   b l o c k ,   i n c l u d i n g   n e s t e d   c a l l s   ( a n d   a l l   t o   a n y   o s a x   a n d   a p p l i c a t i o n   h a n d l e r s   t h a t   u n d e r s t a n d   c o n s i d e r i n g / i g n o r i n g   a t t r i b u t e s ) .  
 
 T O   D O : 
 
 -   d e c i d e   i f   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   i n   ` s e a r c h   t e x t ` ,   e t c .   s h o u l d   c o n s i d e r   o r   i g n o r e   d i a c r i t i c a l s   a n d   n u m e r i c   s t r i n g s ;   o n c e   d e c i d e d ,   u s e   s a m e   c o m b i n a t i o n s   f o r   L i s t L i b ' s   t e x t   c o m p a r a t o r   f o r   c o n s i s t e n c y 
 
 -   a l s o   p r o v i d e   ` e x a c t   m a t c h `   o p t i o n   i n   ` s e a r c h   t e x t ` ,   e t c .   t h a t   c o n s i d e r s   c a s e ,   d i a c r i t i c a l s ,   h y p h e n s ,   p u n c t u a t i o n   a n d   w h i t e   s p a c e   b u t   i g n o r e s   n u m e r i c   s t r i n g s ? 
 
 -   t o   n o r m a l i z e   t e x t   t h e T e x t   u s i n g   n o r m a l i z a t i o n F o r m   - -   ( Q .   h o w   d o e s   A S   n o r m a l l y   d e a l   w i t h   c o m p o s e d   v s   d e c o m p o s e d   u n i c o d e   c h a r s ? )   - -   T O   D O :   u s e   ` p r e c o m p o s e d   c h a r a c t e r s `   a n d   ` c o m p a t i b i l i t y   m a p p i n g `   b o o l e a n   p a r a m s ?   ( a l s o ,   n e e d   t o   f i g u r e   o u t   w h i c h   i s   p r e f e r r e d   f o r m   t o   u s e   a s   d e f a u l t ) 
 	 	 d e c o m p o s e d S t r i n g W i t h C a n o n i c a l M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   D ) 
 	 	 d e c o m p o s e d S t r i n g W i t h C o m p a t i b i l i t y M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   K D ) 
 	 	 p r e c o m p o s e d S t r i n g W i t h C a n o n i c a l M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   C ) 
 	 	 p r e c o m p o s e d S t r i n g W i t h C o m p a t i b i l i t y M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   K C ) 
 
 
 
 -   ` i n s e r t   i n t o   t e x t ` ,   ` d e l e t e   f r o m   t e x t `   f o r   i n s e r t i n g / r e p l a c i n g / d e l e t i n g   r a n g e s   o f   c h a r a c t e r s   ( c . f .   ` i n s e r t   i n t o   l i s t ` ,   ` d e l e t e   f r o m   l i s t `   i n   L i s t L i b ) 
 
 
 -   a d d   ` m a t c h i n g   f i r s t   i t e m   o n l y `   b o o l e a n   o p t i o n   t o   ` s e a r c h   t e x t `   ( t h i s   a l l o w s   u s e r s   t o   p e r f o r m   i n c r e m e n t a l   m a t c h i n g   f a i r l y   e f f i c i e n t l y   w i t h o u t   h a v i n g   t o   u s e   a n   I t e r a t o r   A P I ) 
 
 -   o p t i o n   t o   u s e   s c r i p t   o b j e c t   a s   ` s e a r c h   t e x t ` ' s   ` r e p l a c i n g   w i t h `   a r g u m e n t ?   t h i s   w o u l d   t a k e   a   m a t c h   r e c o r d   p r o d u c e d   b y   _ f i n d . . . ( )   a n d   r e t u r n   t h e   t e x t   t o   i n s e r t ;   u s e f u l   w h e n   e . g .   u p p e r c a s i n g   m a t c h e d   t e x t   ( c u r r e n t l y   u s e r   h a s   t o   r e p e a t   o v e r   t h e   l i s t   o f   m a t c h   r e c o r d s   r e t u r n e d   b y   ` s e a r c h   t e x t `   a n d   r e p l a c e   e a c h   t e x t   r a n g e   h e r s e l f ) 
 
 -   m a y   b e   w o r t h   i m p l e m e n t i n g   a   " c o m p a r e   t e x t "   c o m m a n d   t h a t   a l l o w s   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   t o   b e   s u p p l i e d   a s   p a r a m e t e r s   ( c o n s i d e r i n g / i g n o r i n g   b l o c k s   c a n ' t   b e   p a r a m e t e r i z e d   a s   t h e y   r e q u i r e   h a r d c o d e d   c o n s t a n t s )   a s   t h i s   w o u l d   a l l o w   c o m p a r i s o n s   t o   b e   s a f e l y   p e r f o r m e d   w i t h o u t   h a v i n g   t o   f u t z   w i t h   c o n s i d e r i n g / i g n o r i n g   b l o c k s   a l l   t h e   t i m e   ( c . f .   M a t h L i b ' s   ` c o m p a r e   n u m b e r ` ) ;   f o r   e x t r a   f l e x i b i l i t y ,   t h e   c o m p a r a t o r   c o n s t r u c t o r   s h o u l d   a l s o   b e   e x p o s e d   a s   a   p u b l i c   c o m m a n d ,   a n d   t h e   r e t u r n e d   o b j e c t   i m p l e m e n t   t h e   s a m e   ` m a k e K e y ` + ` c o m p a r e I t e m s `   m e t h o d s   a s   L i s t L i b ' s   s o r t   c o m p a r a t o r s ,   a l l o w i n g   t h e m   t o   b e   u s e d   i n t e r c h a n g e a b l y   ( o n e   c o u l d   e v e n   a r g u e   f o r   p u t t i n g   a l l   c o m p a r a t o r s   i n t o   t h e i r   o w n   l i b ,   w h i c h   o t h e r   l i b r a r i e s   a n d   u s e r   s c r i p t s   c a n   i m p o r t   w h e n e v e r   t h e y   n e e d   t o   p a r a m e t e r i z e   c o m p a r i s o n   b e h a v i o r ) 
 
 -   ` p a d   t e x t   T E X T   u s i n g   C H A R   t o   L E N G T H   f r o m   [ s t a r t / m i d d l e / e n d ] `   - -   T O   D O :   w h a t   t o   u s e   f o r   c o n s t a n t s ?   ( ` b e g i n n i n g / m i d d l e / e n d   o f   t e x t `   i s   n o   g o o d   a s   t h a t   m a s k s   e x i s t i n g   r e f e r e n c e   f o r m s ) ;   a l s o ,   s h o u l d   t h i s   g o   i n t o   F o r m a t L i b ?   ( c o n s i d e r   a l s o   p a d d i n g   n u m b e r s ,   w h i c h   i s   s i m i l a r   i d e a   b u t   n e e d s   t o   t a k e   i n t o   a c c o u n t   [ e . g . ]   d e c i m a l   p l a c e s ) 
 
 
 -   i m p r o v e   u p p e r c a s e / l o w e r c a s e   i m p l e m e n t a t i o n ;   f r o m   N S S t r i n g . h : 
 
 / *   T h e   f o l l o w i n g   t h r e e   r e t u r n   t h e   c a n o n i c a l   ( n o n - l o c a l i z e d )   m a p p i n g s .   T h e y   a r e   s u i t a b l e   f o r   p r o g r a m m i n g   o p e r a t i o n s   t h a t   r e q u i r e   s t a b l e   r e s u l t s   n o t   d e p e n d i n g   o n   t h e   u s e r ' s   l o c a l e   p r e f e r e n c e .     F o r   l o c a l e - a w a r e   c a s e   m a p p i n g   f o r   s t r i n g s   p r e s e n t e d   t o   u s e r s ,   u s e   t h e   " . . . S t r i n g W i t h L o c a l e : "   m e t h o d s   b e l o w . 
 * / 
 @ p r o p e r t y   ( r e a d o n l y ,   c o p y )   N S S t r i n g   * u p p e r c a s e S t r i n g ; 
 @ p r o p e r t y   ( r e a d o n l y ,   c o p y )   N S S t r i n g   * l o w e r c a s e S t r i n g ; 
 @ p r o p e r t y   ( r e a d o n l y ,   c o p y )   N S S t r i n g   * c a p i t a l i z e d S t r i n g ; 
 
 / *   T h e   f o l l o w i n g   t h r e e   r e t u r n   t h e   l o c a l e - a w a r e   c a s e   m a p p i n g s .   T h e y   a r e   s u i t a b l e   f o r   s t r i n g s   p r e s e n t e d   t o   t h e   u s e r . 
 * / 
 @ p r o p e r t y   ( r e a d o n l y ,   c o p y )   N S S t r i n g   * l o c a l i z e d U p p e r c a s e S t r i n g   N S _ A V A I L A B L E ( 1 0 _ 1 1 ,   9 _ 0 ) ; 
 @ p r o p e r t y   ( r e a d o n l y ,   c o p y )   N S S t r i n g   * l o c a l i z e d L o w e r c a s e S t r i n g   N S _ A V A I L A B L E ( 1 0 _ 1 1 ,   9 _ 0 ) ; 
 @ p r o p e r t y   ( r e a d o n l y ,   c o p y )   N S S t r i n g   * l o c a l i z e d C a p i t a l i z e d S t r i n g   N S _ A V A I L A B L E ( 1 0 _ 1 1 ,   9 _ 0 ) ; 
 
 / *   T h e   f o l l o w i n g   m e t h o d s   p e r f o r m   l o c a l i z e d   c a s e   m a p p i n g s   b a s e d   o n   t h e   l o c a l e   s p e c i f i e d .   P a s s i n g   n i l   i n d i c a t e s   t h e   c a n o n i c a l   m a p p i n g .     F o r   t h e   u s e r   p r e f e r e n c e   l o c a l e   s e t t i n g ,   s p e c i f y   + [ N S L o c a l e   c u r r e n t L o c a l e ] . 
 * / 
 -   ( N S S t r i n g ) u p p e r c a s e S t r i n g W i t h L o c a l e : ( n u l l a b l e   N S L o c a l e ) l o c a l e   N S _ A V A I L A B L E ( 1 0 _ 8 ,   6 _ 0 ) ; 
 -   ( N S S t r i n g ) l o w e r c a s e S t r i n g W i t h L o c a l e : ( n u l l a b l e   N S L o c a l e ) l o c a l e   N S _ A V A I L A B L E ( 1 0 _ 8 ,   6 _ 0 ) ; 
 -   ( N S S t r i n g ) c a p i t a l i z e d S t r i n g W i t h L o c a l e : ( n u l l a b l e   N S L o c a l e ) l o c a l e   N S _ A V A I L A B L E ( 1 0 _ 8 ,   6 _ 0 ) ; 
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      record types     �      r e c o r d   t y p e s      l     ��������  ��  ��       !   j    �� "�� (0 _unmatchedtexttype _UnmatchedTextType " m    ��
�� 
TxtU !  # $ # j    �� %�� $0 _matchedtexttype _MatchedTextType % m    ��
�� 
TxtM $  & ' & j    �� (�� &0 _matchedgrouptype _MatchedGroupType ( m    ��
�� 
TxtG '  ) * ) l     ��������  ��  ��   *  + , + l     ��������  ��  ��   ,  - . - l     �� / 0��   / J D--------------------------------------------------------------------    0 � 1 1 � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - .  2 3 2 l     �� 4 5��   4   support    5 � 6 6    s u p p o r t 3  7 8 7 l     ��������  ��  ��   8  9 : 9 l      ; < = ; j    �� >�� 0 _supportlib _supportLib > N     ? ? 4    �� @
�� 
scpt @ m     A A � B B " L i b r a r y S u p p o r t L i b < "  used for parameter checking    = � C C 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g :  D E D l     ��������  ��  ��   E  F G F l     ��������  ��  ��   G  H I H i    J K J I      �� L���� 
0 _error   L  M N M o      ���� 0 handlername handlerName N  O P O o      ���� 0 etext eText P  Q R Q o      ���� 0 enumber eNumber R  S T S o      ���� 0 efrom eFrom T  U�� U o      ���� 
0 eto eTo��  ��   K n     V W V I    �� X���� &0 throwcommanderror throwCommandError X  Y Z Y m     [ [ � \ \  T e x t L i b Z  ] ^ ] o    ���� 0 handlername handlerName ^  _ ` _ o    ���� 0 etext eText `  a b a o    	���� 0 enumber eNumber b  c d c o   	 
���� 0 efrom eFrom d  e�� e o   
 ���� 
0 eto eTo��  ��   W o     ���� 0 _supportlib _supportLib I  f g f l     ��������  ��  ��   g  h i h l     ��������  ��  ��   i  j k j l     �� l m��   l J D--------------------------------------------------------------------    m � n n � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - k  o p o l     �� q r��   q   Find and Replace Suite    r � s s .   F i n d   a n d   R e p l a c e   S u i t e p  t u t l     ��������  ��  ��   u  v w v i   " x y x I      �� z���� 60 _compileregularexpression _compileRegularExpression z  {�� { o      ���� 0 patterntext patternText��  ��   y k     , | |  } ~ } r       �  J      � �  ��� � m     ��
�� 
msng��   � o      ���� 0 err   ~  � � � r     � � � n    � � � I   	 �� ����� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_ �  � � � o   	 
���� 0 patterntext patternText �  � � � m   
 ����   �  ��� � l    ����� � N     � � n     � � � 4    �� �
�� 
cobj � m    ����  � o    ���� 0 err  ��  ��  ��  ��   � n   	 � � � o    	���� *0 nsregularexpression NSRegularExpression � m    ��
�� misccura � o      ���� 
0 regexp   �  � � � l   ) � � � � Z   ) � ����� � =    � � � o    ���� 
0 regexp   � m    ��
�� 
msng � R    %�� � �
�� .ascrerr ****      � **** � m   # $ � � � � � \ I n v a l i d    f o r    p a r a m e t e r   ( n o t   a   v a l i d   p a t t e r n ) . � �� � �
�� 
errn � m     �����Y � �� ���
�� 
erob � o   ! "���� 0 patterntext patternText��  ��  ��   � U O TO DO: err should contain an NSError but doesn't; this is probably an ASOC bug    � � � � �   T O   D O :   e r r   s h o u l d   c o n t a i n   a n   N S E r r o r   b u t   d o e s n ' t ;   t h i s   i s   p r o b a b l y   a n   A S O C   b u g �  ��� � L   * , � � o   * +���� 
0 regexp  ��   w  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   �   find pattern    � � � �    f i n d   p a t t e r n �  � � � l     ��������  ��  ��   �  � � � i  # & � � � I      �� ����� $0 _matchinforecord _matchInfoRecord �  � � � o      ���� 0 
asocstring 
asocString �  � � � o      ����  0 asocmatchrange asocMatchRange �  � � � o      ���� 0 
textoffset 
textOffset �  ��� � o      ���� 0 
recordtype 
recordType��  ��   � k     # � �  � � � r     
 � � � c      � � � l     ����� � n     � � � I    �� ����� *0 substringwithrange_ substringWithRange_ �  ��� � o    ����  0 asocmatchrange asocMatchRange��  ��   � o     ���� 0 
asocstring 
asocString��  ��   � m    ��
�� 
ctxt � o      ���� 0 	foundtext 	foundText �  � � � l    � � � � r     � � � [     � � � o    ���� 0 
textoffset 
textOffset � l    ���~ � n     � � � 1    �}
�} 
leng � o    �|�| 0 	foundtext 	foundText�  �~   � o      �{�{  0 nexttextoffset nextTextOffset � : 4 calculate the start index of the next AS text range    � � � � h   c a l c u l a t e   t h e   s t a r t   i n d e x   o f   t h e   n e x t   A S   t e x t   r a n g e �  � � � l   �z � ��z   �
 note: record keys are identifiers, not keywords, as 1. library-defined keywords are a huge pain to use outside of `tell script...` blocks and 2. importing the library's terminology into the global namespace via `use script...` is an excellent way to create keyword conflicts; only the class value is a keyword since Script Editor/OSAKit don't correctly handle records that use non-typename values (e.g. `{class:"matched text",...}`), but this shouldn't impact usability as it's really only used for informational purposes    � � � �   n o t e :   r e c o r d   k e y s   a r e   i d e n t i f i e r s ,   n o t   k e y w o r d s ,   a s   1 .   l i b r a r y - d e f i n e d   k e y w o r d s   a r e   a   h u g e   p a i n   t o   u s e   o u t s i d e   o f   ` t e l l   s c r i p t . . . `   b l o c k s   a n d   2 .   i m p o r t i n g   t h e   l i b r a r y ' s   t e r m i n o l o g y   i n t o   t h e   g l o b a l   n a m e s p a c e   v i a   ` u s e   s c r i p t . . . `   i s   a n   e x c e l l e n t   w a y   t o   c r e a t e   k e y w o r d   c o n f l i c t s ;   o n l y   t h e   c l a s s   v a l u e   i s   a   k e y w o r d   s i n c e   S c r i p t   E d i t o r / O S A K i t   d o n ' t   c o r r e c t l y   h a n d l e   r e c o r d s   t h a t   u s e   n o n - t y p e n a m e   v a l u e s   ( e . g .   ` { c l a s s : " m a t c h e d   t e x t " , . . . } ` ) ,   b u t   t h i s   s h o u l d n ' t   i m p a c t   u s a b i l i t y   a s   i t ' s   r e a l l y   o n l y   u s e d   f o r   i n f o r m a t i o n a l   p u r p o s e s �  ��y � l   # � � � � L    # � � J    " � �  � � � K     � � �x � �
�x 
pcls � o    �w�w 0 
recordtype 
recordType � �v � ��v 0 
startindex 
startIndex � o    �u�u 0 
textoffset 
textOffset � �t � ��t 0 endindex endIndex � \     � � � o    �s�s  0 nexttextoffset nextTextOffset � m    �r�r  � �q ��p�q 0 	foundtext 	foundText � o    �o�o 0 	foundtext 	foundText�p   �  ��n � o     �m�m  0 nexttextoffset nextTextOffset�n   �  y TO DO: use fromIndex/toIndex instead of startIndex/endIndex? (see also ListLib; consistent naming would be good to have)    � � � � �   T O   D O :   u s e   f r o m I n d e x / t o I n d e x   i n s t e a d   o f   s t a r t I n d e x / e n d I n d e x ?   ( s e e   a l s o   L i s t L i b ;   c o n s i s t e n t   n a m i n g   w o u l d   b e   g o o d   t o   h a v e )�y   �  � � � l     �l�k�j�l  �k  �j   �  � � � l     �i�h�g�i  �h  �g   �  � � � i  ' * � � � I      �f ��e�f 0 _matchrecords _matchRecords �  � � � o      �d�d 0 
asocstring 
asocString �  � � � o      �c�c  0 asocmatchrange asocMatchRange �  �  � o      �b�b  0 asocstartindex asocStartIndex   o      �a�a 0 
textoffset 
textOffset  o      �`�` (0 nonmatchrecordtype nonMatchRecordType �_ o      �^�^ "0 matchrecordtype matchRecordType�_  �e   � k     V  l     �]	
�]  	 � � important: NSString character indexes aren't guaranteed to be same as AS character indexes, so reconstruct both non-matching and matching AS text values, and calculate accurate AS character ranges from those   
 ��   i m p o r t a n t :   N S S t r i n g   c h a r a c t e r   i n d e x e s   a r e n ' t   g u a r a n t e e d   t o   b e   s a m e   a s   A S   c h a r a c t e r   i n d e x e s ,   s o   r e c o n s t r u c t   b o t h   n o n - m a t c h i n g   a n d   m a t c h i n g   A S   t e x t   v a l u e s ,   a n d   c a l c u l a t e   a c c u r a t e   A S   c h a r a c t e r   r a n g e s   f r o m   t h o s e  r      n     I    �\�[�Z�\ 0 location  �[  �Z   o     �Y�Y  0 asocmatchrange asocMatchRange o      �X�X  0 asocmatchstart asocMatchStart  r     [     o    	�W�W  0 asocmatchstart asocMatchStart l  	 �V�U n  	  I   
 �T�S�R�T 
0 length  �S  �R   o   	 
�Q�Q  0 asocmatchrange asocMatchRange�V  �U   o      �P�P 0 asocmatchend asocMatchEnd  r     K     �O !�O 0 location    o    �N�N  0 asocstartindex asocStartIndex! �M"�L�M 
0 length  " \    #$# o    �K�K  0 asocmatchstart asocMatchStart$ o    �J�J  0 asocstartindex asocStartIndex�L   o      �I�I &0 asocnonmatchrange asocNonMatchRange %&% r    5'(' I      �H)�G�H $0 _matchinforecord _matchInfoRecord) *+* o    �F�F 0 
asocstring 
asocString+ ,-, o     �E�E &0 asocnonmatchrange asocNonMatchRange- ./. o     !�D�D 0 
textoffset 
textOffset/ 0�C0 o   ! "�B�B (0 nonmatchrecordtype nonMatchRecordType�C  �G  ( J      11 232 o      �A�A 0 nonmatchinfo nonMatchInfo3 4�@4 o      �?�? 0 
textoffset 
textOffset�@  & 565 r   6 N787 I      �>9�=�> $0 _matchinforecord _matchInfoRecord9 :;: o   7 8�<�< 0 
asocstring 
asocString; <=< o   8 9�;�;  0 asocmatchrange asocMatchRange= >?> o   9 :�:�: 0 
textoffset 
textOffset? @�9@ o   : ;�8�8 "0 matchrecordtype matchRecordType�9  �=  8 J      AA BCB o      �7�7 0 	matchinfo 	matchInfoC D�6D o      �5�5 0 
textoffset 
textOffset�6  6 E�4E L   O VFF J   O UGG HIH o   O P�3�3 0 nonmatchinfo nonMatchInfoI JKJ o   P Q�2�2 0 	matchinfo 	matchInfoK LML o   Q R�1�1 0 asocmatchend asocMatchEndM N�0N o   R S�/�/ 0 
textoffset 
textOffset�0  �4   � OPO l     �.�-�,�.  �-  �,  P QRQ l     �+�*�)�+  �*  �)  R STS i  + .UVU I      �(W�'�( &0 _matchedgrouplist _matchedGroupListW XYX o      �&�& 0 
asocstring 
asocStringY Z[Z o      �%�% 0 	asocmatch 	asocMatch[ \]\ o      �$�$ 0 
textoffset 
textOffset] ^�#^ o      �"�" &0 includenonmatches includeNonMatches�#  �'  V k     �__ `a` r     bcb J     �!�!  c o      � �  "0 submatchresults subMatchResultsa ded r    fgf \    hih l   
j��j n   
klk I    
����  0 numberofranges numberOfRanges�  �  l o    �� 0 	asocmatch 	asocMatch�  �  i m   
 �� g o      �� 0 groupindexes groupIndexese mnm Z    �op��o ?    qrq o    �� 0 groupindexes groupIndexesr m    ��  p k    �ss tut r    vwv n   xyx I    �z�� 0 rangeatindex_ rangeAtIndex_z {�{ m    ��  �  �  y o    �� 0 	asocmatch 	asocMatchw o      �� (0 asocfullmatchrange asocFullMatchRangeu |}| r    %~~ n   #��� I    #���� 0 location  �  �  � o    �
�
 (0 asocfullmatchrange asocFullMatchRange o      �	�	 &0 asocnonmatchstart asocNonMatchStart} ��� r   & /��� [   & -��� o   & '�� &0 asocnonmatchstart asocNonMatchStart� l  ' ,���� n  ' ,��� I   ( ,���� 
0 length  �  �  � o   ' (�� (0 asocfullmatchrange asocFullMatchRange�  �  � o      �� $0 asocfullmatchend asocFullMatchEnd� ��� Y   0 ��� ����� k   : ��� ��� r   : o��� I      ������� 0 _matchrecords _matchRecords� ��� o   ; <���� 0 
asocstring 
asocString� ��� n  < B��� I   = B������� 0 rangeatindex_ rangeAtIndex_� ���� o   = >���� 0 i  ��  ��  � o   < =���� 0 	asocmatch 	asocMatch� ��� o   B C���� &0 asocnonmatchstart asocNonMatchStart� ��� o   C D���� 0 
textoffset 
textOffset� ��� o   D I���� (0 _unmatchedtexttype _UnmatchedTextType� ���� o   I N���� &0 _matchedgrouptype _MatchedGroupType��  ��  � J      �� ��� o      ���� 0 nonmatchinfo nonMatchInfo� ��� o      ���� 0 	matchinfo 	matchInfo� ��� o      ���� &0 asocnonmatchstart asocNonMatchStart� ���� o      ���� 0 
textoffset 
textOffset��  � ��� Z  p |������� o   p q���� &0 includenonmatches includeNonMatches� r   t x��� o   t u���� 0 nonmatchinfo nonMatchInfo� n      ���  ;   v w� o   u v���� "0 submatchresults subMatchResults��  ��  � ���� r   } ���� o   } ~���� 0 	matchinfo 	matchInfo� n      ���  ;    �� o   ~ ���� "0 submatchresults subMatchResults��  �  0 i  � m   3 4���� � o   4 5���� 0 groupindexes groupIndexes��  � ���� Z   � �������� o   � ����� &0 includenonmatches includeNonMatches� k   � ��� ��� r   � ���� K   � ��� ������ 0 location  � o   � ����� &0 asocnonmatchstart asocNonMatchStart� ������� 
0 length  � \   � ���� o   � ����� $0 asocfullmatchend asocFullMatchEnd� o   � ����� &0 asocnonmatchstart asocNonMatchStart��  � o      ���� &0 asocnonmatchrange asocNonMatchRange� ���� r   � ���� n   � ���� 4   � ����
�� 
cobj� m   � ����� � I   � �������� $0 _matchinforecord _matchInfoRecord� ��� o   � ����� 0 
asocstring 
asocString� ��� o   � ����� &0 asocnonmatchrange asocNonMatchRange� ��� o   � ����� 0 
textoffset 
textOffset� ���� o   � ����� (0 _unmatchedtexttype _UnmatchedTextType��  ��  � n      ���  ;   � �� o   � ����� "0 submatchresults subMatchResults��  ��  ��  ��  �  �  n ���� L   � ��� o   � ����� "0 submatchresults subMatchResults��  T ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  / 2��� I      ������� 0 _findpattern _findPattern� ��� o      ���� 0 thetext theText� ��� o      ���� 0 patterntext patternText� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  ��  � l   ���� k    �� ��� r     ��� n    ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    ���� &0 includenonmatches includeNonMatches� ���� m    �� ���  u n m a t c h e d   t e x t��  ��  � o     ���� 0 _supportlib _supportLib� o      ���� &0 includenonmatches includeNonMatches� ��� r    ��� n      I    ������ (0 asbooleanparameter asBooleanParameter  o    ����  0 includematches includeMatches �� m     �  m a t c h e d   t e x t��  ��   o    ���� 0 _supportlib _supportLib� o      ����  0 includematches includeMatches� 	 r    $

 I    "������ 60 _compileregularexpression _compileRegularExpression �� o    ���� 0 patterntext patternText��  ��   o      ���� 
0 regexp  	  r   % / n  % - I   ( -������ &0 stringwithstring_ stringWithString_ �� o   ( )���� 0 thetext theText��  ��   n  % ( o   & (���� 0 nsstring NSString m   % &��
�� misccura o      ���� 0 
asocstring 
asocString  l  0 3 r   0 3 m   0 1����   o      ���� &0 asocnonmatchstart asocNonMatchStart G A used to calculate NSRanges for non-matching portions of NSString    � �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n g  !  l  4 7"#$" r   4 7%&% m   4 5���� & o      ���� 0 
textoffset 
textOffset# B < used to calculate correct AppleScript start and end indexes   $ �'' x   u s e d   t o   c a l c u l a t e   c o r r e c t   A p p l e S c r i p t   s t a r t   a n d   e n d   i n d e x e s! ()( r   8 <*+* J   8 :����  + o      ���� 0 
resultlist 
resultList) ,-, l  = =��./��  . @ : iterate over each non-matched + matched range in NSString   / �00 t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g- 121 r   = N343 n  = L565 I   > L��7���� @0 matchesinstring_options_range_ matchesInString_options_range_7 898 o   > ?���� 0 
asocstring 
asocString9 :;: m   ? @����  ; <��< J   @ H== >?> m   @ A����  ? @��@ n  A FABA I   B F�������� 
0 length  ��  ��  B o   A B���� 0 
asocstring 
asocString��  ��  ��  6 o   = >���� 
0 regexp  4 o      ����  0 asocmatcharray asocMatchArray2 CDC Y   O �E��FG��E k   _ �HH IJI r   _ gKLK l  _ eM����M n  _ eNON I   ` e��P����  0 objectatindex_ objectAtIndex_P Q��Q o   ` a���� 0 i  ��  ��  O o   _ `����  0 asocmatcharray asocMatchArray��  ��  L o      ���� 0 	asocmatch 	asocMatchJ RSR l  h h��TU��  T � � the first range in match identifies the text matched by the entire pattern, so generate records for full match and its preceding (unmatched) text   U �VV$   t h e   f i r s t   r a n g e   i n   m a t c h   i d e n t i f i e s   t h e   t e x t   m a t c h e d   b y   t h e   e n t i r e   p a t t e r n ,   s o   g e n e r a t e   r e c o r d s   f o r   f u l l   m a t c h   a n d   i t s   p r e c e d i n g   ( u n m a t c h e d )   t e x tS WXW r   h �YZY I      ��[���� 0 _matchrecords _matchRecords[ \]\ o   i j���� 0 
asocstring 
asocString] ^_^ n  j p`a` I   k p��b��� 0 rangeatindex_ rangeAtIndex_b c�~c m   k l�}�}  �~  �  a o   j k�|�| 0 	asocmatch 	asocMatch_ ded o   p q�{�{ &0 asocnonmatchstart asocNonMatchStarte fgf o   q r�z�z 0 
textoffset 
textOffsetg hih o   r w�y�y (0 _unmatchedtexttype _UnmatchedTextTypei j�xj o   w |�w�w $0 _matchedtexttype _MatchedTextType�x  ��  Z J      kk lml o      �v�v 0 nonmatchinfo nonMatchInfom non o      �u�u 0 	matchinfo 	matchInfoo pqp o      �t�t &0 asocnonmatchstart asocNonMatchStartq r�sr o      �r�r 0 
textoffset 
textOffset�s  X sts Z  � �uv�q�pu o   � ��o�o &0 includenonmatches includeNonMatchesv r   � �wxw o   � ��n�n 0 nonmatchinfo nonMatchInfox n      yzy  ;   � �z o   � ��m�m 0 
resultlist 
resultList�q  �p  t {�l{ Z   � �|}�k�j| o   � ��i�i  0 includematches includeMatches} k   � �~~ � l  � ��h���h  � any additional ranges in match identify text matched by group references within regexp pattern, e.g. "([0-9]{4})-([0-9]{2})-([0-9]{2})" will match `YYYY-MM-DD` style date strings, returning the entire text match, plus sub-matches representing year, month and day text   � ���   a n y   a d d i t i o n a l   r a n g e s   i n   m a t c h   i d e n t i f y   t e x t   m a t c h e d   b y   g r o u p   r e f e r e n c e s   w i t h i n   r e g e x p   p a t t e r n ,   e . g .   " ( [ 0 - 9 ] { 4 } ) - ( [ 0 - 9 ] { 2 } ) - ( [ 0 - 9 ] { 2 } ) "   w i l l   m a t c h   ` Y Y Y Y - M M - D D `   s t y l e   d a t e   s t r i n g s ,   r e t u r n i n g   t h e   e n t i r e   t e x t   m a t c h ,   p l u s   s u b - m a t c h e s   r e p r e s e n t i n g   y e a r ,   m o n t h   a n d   d a y   t e x t� ��g� r   � ���� b   � ���� o   � ��f�f 0 	matchinfo 	matchInfo� K   � ��� �e��d�e 0 foundgroups foundGroups� I   � ��c��b�c &0 _matchedgrouplist _matchedGroupList� ��� o   � ��a�a 0 
asocstring 
asocString� ��� o   � ��`�` 0 	asocmatch 	asocMatch� ��� n  � ���� o   � ��_�_ 0 
startindex 
startIndex� o   � ��^�^ 0 	matchinfo 	matchInfo� ��]� o   � ��\�\ &0 includenonmatches includeNonMatches�]  �b  �d  � n      ���  ;   � �� o   � ��[�[ 0 
resultlist 
resultList�g  �k  �j  �l  �� 0 i  F m   R S�Z�Z  G \   S Z��� l  S X��Y�X� n  S X��� I   T X�W�V�U�W 	0 count  �V  �U  � o   S T�T�T  0 asocmatcharray asocMatchArray�Y  �X  � m   X Y�S�S ��  D ��� l  � ��R���R  � "  add final non-matched range   � ��� 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e� ��� Z   ����Q�P� o   � ��O�O &0 includenonmatches includeNonMatches� k   � �� ��� r   � ���� c   � ���� l  � ���N�M� n  � ���� I   � ��L��K�L *0 substringfromindex_ substringFromIndex_� ��J� o   � ��I�I &0 asocnonmatchstart asocNonMatchStart�J  �K  � o   � ��H�H 0 
asocstring 
asocString�N  �M  � m   � ��G
�G 
ctxt� o      �F�F 0 	foundtext 	foundText� ��E� r   � ��� K   � ��� �D��
�D 
pcls� o   � ��C�C (0 _unmatchedtexttype _UnmatchedTextType� �B���B 0 
startindex 
startIndex� o   � ��A�A 0 
textoffset 
textOffset� �@���@ 0 endindex endIndex� n   � ���� 1   � ��?
�? 
leng� o   � ��>�> 0 thetext theText� �=��<�= 0 	foundtext 	foundText� o   � ��;�; 0 	foundtext 	foundText�<  � n      ���  ;   � �� o   � ��:�: 0 
resultlist 
resultList�E  �Q  �P  � ��9� L  �� o  �8�8 0 
resultlist 
resultList�9  � ' ! TO DO: what about normalization?   � ��� B   T O   D O :   w h a t   a b o u t   n o r m a l i z a t i o n ?� ��� l     �7�6�5�7  �6  �5  � ��� l     �4�3�2�4  �3  �2  � ��� l     �1���1  �  -----   � ��� 
 - - - - -� ��� l     �0���0  �   replace pattern   � ���     r e p l a c e   p a t t e r n� ��� l     �/�.�-�/  �.  �-  � ��� i  3 6��� I      �,��+�, "0 _replacepattern _replacePattern� ��� o      �*�* 0 thetext theText� ��� o      �)�) 0 patterntext patternText� ��(� o      �'�' 0 templatetext templateText�(  �+  � l    %���� k     %�� ��� r     
��� n    ��� I    �&��%�& &0 stringwithstring_ stringWithString_� ��$� o    �#�# 0 thetext theText�$  �%  � n    ��� o    �"�" 0 nsstring NSString� m     �!
�! misccura� o      � �  0 
asocstring 
asocString� ��� r    ��� I    ���� 60 _compileregularexpression _compileRegularExpression� ��� o    �� 0 patterntext patternText�  �  � o      �� 
0 regexp  � ��� L    %�� n   $��� I    $���� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_� ��� o    �� 0 
asocstring 
asocString� ��� m    ��  � ��� J    �� ��� m    ��  � ��� n      I    ���� 
0 length  �  �   o    �� 0 
asocstring 
asocString�  � � o     �� 0 templatetext templateText�  �  � o    �� 
0 regexp  �  � ' ! TO DO: what about normalization?   � � B   T O   D O :   w h a t   a b o u t   n o r m a l i z a t i o n ?�  l     ���
�  �  �
    l     �	���	  �  �   	 l     �
�  
  -----    � 
 - - - - -	  l     ��    
 find text    �    f i n d   t e x t  l     ����  �  �    i  7 : I      �� � 0 	_findtext 	_findText  o      ���� 0 thetext theText  o      ���� 0 fortext forText  o      ���� &0 includenonmatches includeNonMatches �� o      ����  0 includematches includeMatches��  �    k    '   !"! l     ��#$��  #�� TO DO: is it worth switching to a more efficient algorithim when hypens, punctuation, and white space are all considered and numeric strings ignored (the default)? i.e. given a fixed-length match, the endIndex of a match can be determined using `forText's length + startIndex - 1` instead of measuring the length of all remaining text after `text item i`; will need to implement both approaches and profile them to determine if it makes any significant difference to speed   $ �%%�   T O   D O :   i s   i t   w o r t h   s w i t c h i n g   t o   a   m o r e   e f f i c i e n t   a l g o r i t h i m   w h e n   h y p e n s ,   p u n c t u a t i o n ,   a n d   w h i t e   s p a c e   a r e   a l l   c o n s i d e r e d   a n d   n u m e r i c   s t r i n g s   i g n o r e d   ( t h e   d e f a u l t ) ?   i . e .   g i v e n   a   f i x e d - l e n g t h   m a t c h ,   t h e   e n d I n d e x   o f   a   m a t c h   c a n   b e   d e t e r m i n e d   u s i n g   ` f o r T e x t ' s   l e n g t h   +   s t a r t I n d e x   -   1 `   i n s t e a d   o f   m e a s u r i n g   t h e   l e n g t h   o f   a l l   r e m a i n i n g   t e x t   a f t e r   ` t e x t   i t e m   i ` ;   w i l l   n e e d   t o   i m p l e m e n t   b o t h   a p p r o a c h e s   a n d   p r o f i l e   t h e m   t o   d e t e r m i n e   i f   i t   m a k e s   a n y   s i g n i f i c a n t   d i f f e r e n c e   t o   s p e e d" &'& l     ��������  ��  ��  ' ()( l    *+,* Z    -.����- =    /0/ o     ���� 0 fortext forText0 m    11 �22  . R    ��34
�� .ascrerr ****      � ****3 m    55 �66 � I n v a l i d    f o r    p a r a m e t e r   ( t e x t   i s   e m p t y ,   o r   o n l y   c o n t a i n s   c h a r a c t e r s   i g n o r e d   b y   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s )4 ��78
�� 
errn7 m    	�����Y8 ��9��
�� 
erob9 o   
 ���� 0 fortext forText��  ��  ��  +�� checks if all characters in forText are ignored by current considering/ignoring settings (the alternative would be to return each character as a non-match separated by a zero-length match, but that's probably not what the user intended); note that unlike `aString's length = 0`, which is what library code normally uses to check for empty text, on this occasion we do want to take into account the current considering/ignoring settings so deliberately use `forText is ""` here. For example, when ignoring punctuation, searching for the TID `"!?"` is no different to searching for `""`, because all of its characters are being ignored when comparing the text being searched against the text being searched for. Thus, a simple `forText is ""` test can be used to check in advance if the text contains any matchable characters under the current considering/ignoring settings, and report a meaningful error if not.   , �::   c h e c k s   i f   a l l   c h a r a c t e r s   i n   f o r T e x t   a r e   i g n o r e d   b y   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   ( t h e   a l t e r n a t i v e   w o u l d   b e   t o   r e t u r n   e a c h   c h a r a c t e r   a s   a   n o n - m a t c h   s e p a r a t e d   b y   a   z e r o - l e n g t h   m a t c h ,   b u t   t h a t ' s   p r o b a b l y   n o t   w h a t   t h e   u s e r   i n t e n d e d ) ;   n o t e   t h a t   u n l i k e   ` a S t r i n g ' s   l e n g t h   =   0 ` ,   w h i c h   i s   w h a t   l i b r a r y   c o d e   n o r m a l l y   u s e s   t o   c h e c k   f o r   e m p t y   t e x t ,   o n   t h i s   o c c a s i o n   w e   d o   w a n t   t o   t a k e   i n t o   a c c o u n t   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   s o   d e l i b e r a t e l y   u s e   ` f o r T e x t   i s   " " `   h e r e .   F o r   e x a m p l e ,   w h e n   i g n o r i n g   p u n c t u a t i o n ,   s e a r c h i n g   f o r   t h e   T I D   ` " ! ? " `   i s   n o   d i f f e r e n t   t o   s e a r c h i n g   f o r   ` " " ` ,   b e c a u s e   a l l   o f   i t s   c h a r a c t e r s   a r e   b e i n g   i g n o r e d   w h e n   c o m p a r i n g   t h e   t e x t   b e i n g   s e a r c h e d   a g a i n s t   t h e   t e x t   b e i n g   s e a r c h e d   f o r .   T h u s ,   a   s i m p l e   ` f o r T e x t   i s   " " `   t e s t   c a n   b e   u s e d   t o   c h e c k   i n   a d v a n c e   i f   t h e   t e x t   c o n t a i n s   a n y   m a t c h a b l e   c h a r a c t e r s   u n d e r   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s ,   a n d   r e p o r t   a   m e a n i n g f u l   e r r o r   i f   n o t .) ;<; r    =>= J    ����  > o      ���� 0 
resultlist 
resultList< ?@? r    ABA n   CDC 1    ��
�� 
txdlD 1    ��
�� 
ascrB o      ���� 0 oldtids oldTIDs@ EFE r    #GHG o    ���� 0 fortext forTextH n     IJI 1     "��
�� 
txdlJ 1     ��
�� 
ascrF KLK r   $ 'MNM m   $ %���� N o      ���� 0 
startindex 
startIndexL OPO r   ( 0QRQ n   ( .STS 1   , .��
�� 
lengT n   ( ,UVU 4   ) ,��W
�� 
citmW m   * +���� V o   ( )���� 0 thetext theTextR o      ���� 0 endindex endIndexP XYX Z   1 JZ[��\Z B   1 4]^] o   1 2���� 0 
startindex 
startIndex^ o   2 3���� 0 endindex endIndex[ r   7 D_`_ n   7 Baba 7  8 B��cd
�� 
ctxtc o   < >���� 0 
startindex 
startIndexd o   ? A���� 0 endindex endIndexb o   7 8���� 0 thetext theText` o      ���� 0 	foundtext 	foundText��  \ r   G Jefe m   G Hgg �hh  f o      ���� 0 	foundtext 	foundTextY iji Z  K fkl����k o   K L���� &0 includenonmatches includeNonMatchesl r   O bmnm K   O _oo ��pq
�� 
pclsp o   P U���� (0 _unmatchedtexttype _UnmatchedTextTypeq ��rs�� 0 
startindex 
startIndexr o   V W���� 0 
startindex 
startIndexs ��tu�� 0 endindex endIndext o   X Y���� 0 endindex endIndexu ��v���� 0 	foundtext 	foundTextv o   Z [���� 0 	foundtext 	foundText��  n n      wxw  ;   ` ax o   _ `���� 0 
resultlist 
resultList��  ��  j yzy Y   g{��|}��{ k   w~~ � r   w |��� [   w z��� o   w x���� 0 endindex endIndex� m   x y���� � o      ���� 0 
startindex 
startIndex� ��� r   } ���� \   } ���� l  } ������� n   } ���� 1   ~ ���
�� 
leng� o   } ~���� 0 thetext theText��  ��  � l  � ������� n   � ���� 1   � ���
�� 
leng� n   � ���� 7  � �����
�� 
ctxt� l  � ������� 4   � ����
�� 
citm� o   � ����� 0 i  ��  ��  � m   � �������� o   � ����� 0 thetext theText��  ��  � o      ���� 0 endindex endIndex� ��� Z   � ������� B   � ���� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� r   � ���� n   � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText� o      ���� 0 	foundtext 	foundText��  � r   � ���� m   � ��� ���  � o      ���� 0 	foundtext 	foundText� ��� Z  � �������� o   � �����  0 includematches includeMatches� r   � ���� K   � ��� ����
�� 
pcls� o   � ����� $0 _matchedtexttype _MatchedTextType� ������ 0 
startindex 
startIndex� o   � ����� 0 
startindex 
startIndex� ������ 0 endindex endIndex� o   � ����� 0 endindex endIndex� ������ 0 	foundtext 	foundText� o   � ����� 0 	foundtext 	foundText� ������� 0 foundgroups foundGroups� J   � �����  ��  � n      ���  ;   � �� o   � ����� 0 
resultlist 
resultList��  ��  � ��� r   � ���� [   � ���� o   � ����� 0 endindex endIndex� m   � ����� � o      ���� 0 
startindex 
startIndex� ��� r   � ���� \   � ���� [   � ���� o   � ����� 0 
startindex 
startIndex� l  � ������� n   � ���� 1   � ���
�� 
leng� n   � ���� 4   � ����
�� 
citm� o   � ����� 0 i  � o   � ����� 0 thetext theText��  ��  � m   � ����� � o      ���� 0 endindex endIndex� ��� Z   � ������� B   � ���� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� r   � ���� n   � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText� o      ���� 0 	foundtext 	foundText��  � r   � ���� m   � ��� ���  � o      ���� 0 	foundtext 	foundText� ���� Z  �������� o   � ����� &0 includenonmatches includeNonMatches� r  ��� K  �� ����
�� 
pcls� o  ���� (0 _unmatchedtexttype _UnmatchedTextType� ������ 0 
startindex 
startIndex� o  	
���� 0 
startindex 
startIndex� ���� 0 endindex endIndex� o  �~�~ 0 endindex endIndex� �}��|�} 0 	foundtext 	foundText� o  �{�{ 0 	foundtext 	foundText�|  � n      ���  ;  � o  �z�z 0 
resultlist 
resultList��  ��  ��  �� 0 i  | m   j k�y�y } I  k r�x��w
�x .corecnte****       ****� n   k n��� 2  l n�v
�v 
citm� o   k l�u�u 0 thetext theText�w  ��  z ��� r  $��� o   �t�t 0 oldtids oldTIDs� n     ��� 1  !#�s
�s 
txdl� 1   !�r
�r 
ascr� ��q� L  %'�� o  %&�p�p 0 
resultlist 
resultList�q   ��� l     �o�n�m�o  �n  �m  � ��� l     �l�k�j�l  �k  �j  � ��� l     �i� �i  �  -----     � 
 - - - - -�  l     �h�h     replace text    �    r e p l a c e   t e x t  l     �g�f�e�g  �f  �e   	
	 i  ; > I      �d�c�d 0 _replacetext _replaceText  o      �b�b 0 thetext theText  o      �a�a 0 fortext forText �` o      �_�_ 0 newtext newText�`  �c   k     &  r      n     1    �^
�^ 
txdl 1     �]
�] 
ascr o      �\�\ 0 oldtids oldTIDs  r     o    �[�[ 0 fortext forText n      1    
�Z
�Z 
txdl 1    �Y
�Y 
ascr  !  l   "#$" r    %&% n   '(' 2   �X
�X 
citm( o    �W�W 0 thetext theText& o      �V�V 0 	textitems 	textItems# J D note: TID-based matching uses current considering/ignoring settings   $ �)) �   n o t e :   T I D - b a s e d   m a t c h i n g   u s e s   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s! *+* r    ,-, o    �U�U 0 newtext newText- n     ./. 1    �T
�T 
txdl/ 1    �S
�S 
ascr+ 010 r    232 c    454 o    �R�R 0 	textitems 	textItems5 m    �Q
�Q 
ctxt3 o      �P�P 0 
resulttext 
resultText1 676 r    #898 o    �O�O 0 oldtids oldTIDs9 n     :;: 1     "�N
�N 
txdl; 1     �M
�M 
ascr7 <�L< L   $ &== o   $ %�K�K 0 
resulttext 
resultText�L  
 >?> l     �J�I�H�J  �I  �H  ? @A@ l     �G�F�E�G  �F  �E  A BCB l     �DDE�D  D  -----   E �FF 
 - - - - -C GHG l     �C�B�A�C  �B  �A  H IJI i  ? BKLK I     �@MN
�@ .Txt:Srchnull���     ctxtM o      �?�? 0 thetext theTextN �>OP
�> 
For_O o      �=�= 0 fortext forTextP �<QR
�< 
UsinQ |�;�:S�9T�;  �:  S o      �8�8 0 matchformat matchFormat�9  T l 
    U�7�6U l     V�5�4V m      �3
�3 SerECmpI�5  �4  �7  �6  R �2WX
�2 
ReplW |�1�0Y�/Z�1  �0  Y o      �.�. 0 newtext newText�/  Z l     [�-�,[ m      �+
�+ 
msng�-  �,  X �*\�)
�* 
Retu\ |�(�']�&^�(  �'  ] o      �%�% 0 resultformat resultFormat�&  ^ l     _�$�#_ m      �"
�" RetEMatT�$  �#  �)  L Q    �`ab` k   �cc ded r    fgf n   hih I    �!j� �! "0 astextparameter asTextParameterj klk o    	�� 0 thetext theTextl m�m m   	 
nn �oo  �  �   i o    �� 0 _supportlib _supportLibg o      �� 0 thetext theTexte pqp l   rstr r    uvu n   wxw I    �y�� "0 astextparameter asTextParametery z{z o    �� 0 fortext forText{ |�| m    }} �~~  f o r�  �  x o    �� 0 _supportlib _supportLibv o      �� 0 fortext forTexts TO DO: when matching with TIDs, optionally accept a list of multiple text values to match? (note:TIDs can do that for free, so it'd just be a case of relaxing restriction on 'for' parameter's type when pattern matching is false to accept a list of text as well); also optionally accept a corresponding list of replacement values for doing mapping? (note that map will need to be O(n) associative list in order to support considering/ignoring, although NSDictionary should be usable when matching case-sensitively)   t �   T O   D O :   w h e n   m a t c h i n g   w i t h   T I D s ,   o p t i o n a l l y   a c c e p t   a   l i s t   o f   m u l t i p l e   t e x t   v a l u e s   t o   m a t c h ?   ( n o t e : T I D s   c a n   d o   t h a t   f o r   f r e e ,   s o   i t ' d   j u s t   b e   a   c a s e   o f   r e l a x i n g   r e s t r i c t i o n   o n   ' f o r '   p a r a m e t e r ' s   t y p e   w h e n   p a t t e r n   m a t c h i n g   i s   f a l s e   t o   a c c e p t   a   l i s t   o f   t e x t   a s   w e l l ) ;   a l s o   o p t i o n a l l y   a c c e p t   a   c o r r e s p o n d i n g   l i s t   o f   r e p l a c e m e n t   v a l u e s   f o r   d o i n g   m a p p i n g ?   ( n o t e   t h a t   m a p   w i l l   n e e d   t o   b e   O ( n )   a s s o c i a t i v e   l i s t   i n   o r d e r   t o   s u p p o r t   c o n s i d e r i n g / i g n o r i n g ,   a l t h o u g h   N S D i c t i o n a r y   s h o u l d   b e   u s a b l e   w h e n   m a t c h i n g   c a s e - s e n s i t i v e l y )q ��� Z   3����� =    $��� n    "��� 1     "�
� 
leng� o     �� 0 fortext forText� m   " #��  � R   ' /���
� .ascrerr ****      � ****� m   - .�� ��� t I n v a l i d    f o r    p a r a m e t e r   ( e x p e c t e d   o n e   o r   m o r e   c h a r a c t e r s ) .� ���
� 
errn� m   ) *���Y� ���
� 
erob� o   + ,�� 0 fortext forText�  �  �  � ��
� Z   4����	�� =  4 7��� o   4 5�� 0 newtext newText� m   5 6�
� 
msng� l  :���� k   :�� ��� Z   : ������ =  : =��� o   : ;�� 0 resultformat resultFormat� m   ; <�
� RetEMatT� r   @ S��� J   @ D�� ��� m   @ A�
� boovfals� ��� m   A B�
� boovtrue�  � J      �� ��� o      �� &0 includenonmatches includeNonMatches� �� � o      ����  0 includematches includeMatches�   � ��� =  V Y��� o   V W���� 0 resultformat resultFormat� m   W X��
�� RetEUmaT� ��� r   \ o��� J   \ `�� ��� m   \ ]��
�� boovtrue� ���� m   ] ^��
�� boovfals��  � J      �� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  � ��� =  r u��� o   r s���� 0 resultformat resultFormat� m   s t��
�� RetEAllT� ���� r   x ���� J   x |�� ��� m   x y��
�� boovtrue� ���� m   y z��
�� boovtrue��  � J      �� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  ��  � R   � �����
�� .ascrerr ****      � ****� m   � ��� ��� p I n v a l i d    r e t u r n i n g    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .� ����
�� 
errn� m   � ������Y� ����
�� 
erob� o   � ����� 0 resultformat resultFormat� �����
�� 
errt� m   � ���
�� 
enum��  � ���� Z   ������ =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpI� P   � ����� L   � ��� I   � �������� 0 	_findtext 	_findText� ��� o   � ����� 0 thetext theText� ��� o   � ����� 0 fortext forText� ��� o   � ����� &0 includenonmatches includeNonMatches� ���� o   � �����  0 includematches includeMatches��  ��  � ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ���
�� conswhit� ����
�� consnume��  � ����
�� conscase��  � ��� =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpP� ��� L   � ��� I   � �������� 0 _findpattern _findPattern� ��� o   � ����� 0 thetext theText� ��� o   � ����� 0 fortext forText� ��� o   � ����� &0 includenonmatches includeNonMatches� ���� o   � �����  0 includematches includeMatches��  ��  � ��� =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpC� ��� P   � �� ��� L   � � I   � ������� 0 	_findtext 	_findText  o   � ����� 0 thetext theText  o   � ����� 0 fortext forText  o   � ����� &0 includenonmatches includeNonMatches 	��	 o   � �����  0 includematches includeMatches��  ��    ��

�� conscase
 ��
�� consdiac ��
�� conshyph ��
�� conspunc ��
�� conswhit ����
�� consnume��  ��  �  =  � � o   � ����� 0 matchformat matchFormat m   � ���
�� SerECmpD �� L   �  I   � ������� 0 	_findtext 	_findText  o   � ����� 0 thetext theText  o   � ����� 0 fortext forText  o   � ����� &0 includenonmatches includeNonMatches �� o   � �����  0 includematches includeMatches��  ��  ��  � R  ��
�� .ascrerr ****      � **** m   �   h I n v a l i d    u s i n g    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) . ��!"
�� 
errn! m  �����Y" ��#$
�� 
erob# o  ���� 0 matchformat matchFormat$ ��%��
�� 
errt% m  	
��
�� 
enum��  ��  �   find   � �&& 
   f i n d�	  � l �'()' k  �** +,+ r  #-.- n !/0/ I  !��1���� "0 astextparameter asTextParameter1 232 o  ���� 0 newtext newText3 4��4 m  55 �66  r e p l a c i n g   w i t h��  ��  0 o  ���� 0 _supportlib _supportLib. o      ���� 0 newtext newText, 7��7 Z  $�89:;8 = $)<=< o  $%���� 0 matchformat matchFormat= m  %(��
�� SerECmpI9 P  ,?>?@> L  5>AA I  5=��B���� 0 _replacetext _replaceTextB CDC o  67���� 0 thetext theTextD EFE o  78���� 0 fortext forTextF G��G o  89���� 0 newtext newText��  ��  ? ��H
�� consdiacH ��I
�� conshyphI ��J
�� conspuncJ ��K
�� conswhitK ����
�� consnume��  @ ����
�� conscase��  : LML = BGNON o  BC���� 0 matchformat matchFormatO m  CF��
�� SerECmpPM PQP L  JSRR I  JR��S���� "0 _replacepattern _replacePatternS TUT o  KL���� 0 thetext theTextU VWV o  LM���� 0 fortext forTextW X��X o  MN���� 0 newtext newText��  ��  Q YZY = V[[\[ o  VW���� 0 matchformat matchFormat\ m  WZ��
�� SerECmpCZ ]^] P  ^o_`��_ L  enaa I  em��b���� 0 _replacetext _replaceTextb cdc o  fg���� 0 thetext theTextd efe o  gh���� 0 fortext forTextf g��g o  hi���� 0 newtext newText��  ��  ` �h
� conscaseh �~i
�~ consdiaci �}j
�} conshyphj �|k
�| conspunck �{l
�{ conswhitl �z�y
�z consnume�y  ��  ^ mnm = rwopo o  rs�x�x 0 matchformat matchFormatp m  sv�w
�w SerECmpDn q�vq L  z�rr I  z��us�t�u 0 _replacetext _replaceTexts tut o  {|�s�s 0 thetext theTextu vwv o  |}�r�r 0 fortext forTextw x�qx o  }~�p�p 0 newtext newText�q  �t  �v  ; R  ���oyz
�o .ascrerr ****      � ****y m  ��{{ �|| h I n v a l i d    u s i n g    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .z �n}~
�n 
errn} m  ���m�m�Y~ �l�
�l 
erob o  ���k�k 0 matchformat matchFormat� �j��i
�j 
errt� m  ���h
�h 
enum�i  ��  (   replace   ) ���    r e p l a c e�
  a R      �g��
�g .ascrerr ****      � ****� o      �f�f 0 etext eText� �e��
�e 
errn� o      �d�d 0 enumber eNumber� �c��
�c 
erob� o      �b�b 0 efrom eFrom� �a��`
�a 
errt� o      �_�_ 
0 eto eTo�`  b I  ���^��]�^ 
0 _error  � ��� m  ���� ���  s e a r c h   t e x t� ��� o  ���\�\ 0 etext eText� ��� o  ���[�[ 0 enumber eNumber� ��� o  ���Z�Z 0 efrom eFrom� ��Y� o  ���X�X 
0 eto eTo�Y  �]  J ��� l     �W�V�U�W  �V  �U  � ��� l     �T�S�R�T  �S  �R  � ��� i  C F��� I     �Q��P
�Q .Txt:EPatnull���     ctxt� o      �O�O 0 thetext theText�P  � Q     *���� L    �� c    ��� l   ��N�M� n   ��� I    �L��K�L 40 escapedpatternforstring_ escapedPatternForString_� ��J� l   ��I�H� n   ��� I    �G��F�G "0 astextparameter asTextParameter� ��� o    �E�E 0 thetext theText� ��D� m    �� ���  �D  �F  � o    �C�C 0 _supportlib _supportLib�I  �H  �J  �K  � n   ��� o    �B�B *0 nsregularexpression NSRegularExpression� m    �A
�A misccura�N  �M  � m    �@
�@ 
ctxt� R      �?��
�? .ascrerr ****      � ****� o      �>�> 0 etext eText� �=��
�= 
errn� o      �<�< 0 enumber eNumber� �;��
�; 
erob� o      �:�: 0 efrom eFrom� �9��8
�9 
errt� o      �7�7 
0 eto eTo�8  � I     *�6��5�6 
0 _error  � ��� m   ! "�� ��� B e s c a p e   r e g u l a r   e x p r e s s i o n   p a t t e r n� ��� o   " #�4�4 0 etext eText� ��� o   # $�3�3 0 enumber eNumber� ��� o   $ %�2�2 0 efrom eFrom� ��1� o   % &�0�0 
0 eto eTo�1  �5  � ��� l     �/�.�-�/  �.  �-  � ��� l     �,�+�*�,  �+  �*  � ��� i  G J��� I     �)��(
�) .Txt:ETemnull���     ctxt� o      �'�' 0 thetext theText�(  � Q     *���� L    �� c    ��� l   ��&�%� n   ��� I    �$��#�$ 60 escapedtemplateforstring_ escapedTemplateForString_� ��"� l   ��!� � n   ��� I    ���� "0 astextparameter asTextParameter� ��� o    �� 0 thetext theText� ��� m    �� ���  �  �  � o    �� 0 _supportlib _supportLib�!  �   �"  �#  � n   ��� o    �� *0 nsregularexpression NSRegularExpression� m    �
� misccura�&  �%  � m    �
� 
ctxt� R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  � I     *���� 
0 _error  � ��� m   ! "�� ��� D e s c a p e   r e g u l a r   e x p r e s s i o n   t e m p l a t e� ��� o   " #�� 0 etext eText� ��� o   # $�� 0 enumber eNumber� ��� o   $ %�
�
 0 efrom eFrom� ��	� o   % &�� 
0 eto eTo�	  �  � ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l     � �    J D--------------------------------------------------------------------    � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -�  l     � �      Conversion Suite    � "   C o n v e r s i o n   S u i t e 	 l     ��������  ��  ��  	 

 i  K N I      ������ 0 	_pinindex 	_pinIndex  o      ���� 0 theindex theIndex �� o      ���� 0 
textlength 
textLength��  ��   l    % Z     % ?      o     ���� 0 theindex theIndex o    ���� 0 
textlength 
textLength L     o    ���� 0 
textlength 
textLength  A     o    ���� 0 theindex theIndex d       o    ���� 0 
textlength 
textLength !"! L    ## d    $$ o    ���� 0 
textlength 
textLength" %&% =    '(' o    ���� 0 theindex theIndex( m    ����  & )��) L     ** m    ���� ��   L   # %++ o   # $���� 0 theindex theIndex i c used by `slice text` to prevent 'out of range' errors (caution: textLength must be greater than 0)    �,, �   u s e d   b y   ` s l i c e   t e x t `   t o   p r e v e n t   ' o u t   o f   r a n g e '   e r r o r s   ( c a u t i o n :   t e x t L e n g t h   m u s t   b e   g r e a t e r   t h a n   0 ) -.- l     ��������  ��  ��  . /0/ l     ��������  ��  ��  0 121 l     ��34��  3  -----   4 �55 
 - - - - -2 676 l     ��������  ��  ��  7 898 i  O R:;: I     ��<��
�� .Txt:UppTnull���     ctxt< o      ���� 0 thetext theText��  ; Q     .=>?= L    @@ c    ABA l   C����C n   DED I    �������� "0 lowercasestring lowercaseString��  ��  E l   F����F n   GHG I    ��I���� &0 stringwithstring_ stringWithString_I J��J l   K����K n   LML I    ��N���� "0 astextparameter asTextParameterN OPO o    ���� 0 thetext theTextP Q��Q m    RR �SS  ��  ��  M o    ���� 0 _supportlib _supportLib��  ��  ��  ��  H n   TUT o    ���� 0 nsstring NSStringU m    ��
�� misccura��  ��  ��  ��  B m    ��
�� 
ctxt> R      ��VW
�� .ascrerr ****      � ****V o      ���� 0 etext eTextW ��XY
�� 
errnX o      ���� 0 enumber eNumberY ��Z[
�� 
erobZ o      ���� 0 efrom eFrom[ ��\��
�� 
errt\ o      ���� 
0 eto eTo��  ? I   $ .��]���� 
0 _error  ] ^_^ m   % &`` �aa  u p p e r c a s e   t e x t_ bcb o   & '���� 0 etext eTextc ded o   ' (���� 0 enumber eNumbere fgf o   ( )���� 0 efrom eFromg h��h o   ) *���� 
0 eto eTo��  ��  9 iji l     ��������  ��  ��  j klk l     ��������  ��  ��  l mnm i  S Vopo I     ��q��
�� .Txt:CapTnull���     ctxtq o      ���� 0 thetext theText��  p Q     .rstr L    uu c    vwv l   x����x n   yzy I    �������� $0 capitalizestring capitalizeString��  ��  z l   {����{ n   |}| I    ��~���� &0 stringwithstring_ stringWithString_~ �� l   ������ n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    ���� 0 thetext theText� ���� m    �� ���  ��  ��  � o    ���� 0 _supportlib _supportLib��  ��  ��  ��  } n   ��� o    ���� 0 nsstring NSString� m    ��
�� misccura��  ��  ��  ��  w m    ��
�� 
ctxts R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  t I   $ .������� 
0 _error  � ��� m   % &�� ���  c a p i t a l i z e   t e x t� ��� o   & '���� 0 etext eText� ��� o   ' (���� 0 enumber eNumber� ��� o   ( )���� 0 efrom eFrom� ���� o   ) *���� 
0 eto eTo��  ��  n ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  W Z��� I     �����
�� .Txt:LowTnull���     ctxt� o      ���� 0 thetext theText��  � Q     .���� L    �� c    ��� l   ������ n   ��� I    �������� "0 lowercasestring lowercaseString��  ��  � l   ����� n   ��� I    �~��}�~ &0 stringwithstring_ stringWithString_� ��|� l   ��{�z� n   ��� I    �y��x�y "0 astextparameter asTextParameter� ��� o    �w�w 0 thetext theText� ��v� m    �� ���  �v  �x  � o    �u�u 0 _supportlib _supportLib�{  �z  �|  �}  � n   ��� o    �t�t 0 nsstring NSString� m    �s
�s misccura��  �  ��  ��  � m    �r
�r 
ctxt� R      �q��
�q .ascrerr ****      � ****� o      �p�p 0 etext eText� �o��
�o 
errn� o      �n�n 0 enumber eNumber� �m��
�m 
erob� o      �l�l 0 efrom eFrom� �k��j
�k 
errt� o      �i�i 
0 eto eTo�j  � I   $ .�h��g�h 
0 _error  � ��� m   % &�� ���  l o w e r c a s e   t e x t� ��� o   & '�f�f 0 etext eText� ��� o   ' (�e�e 0 enumber eNumber� ��� o   ( )�d�d 0 efrom eFrom� ��c� o   ) *�b�b 
0 eto eTo�c  �g  � ��� l     �a�`�_�a  �`  �_  � ��� l     �^�]�\�^  �]  �\  � ��� i  [ ^��� I     �[��
�[ .Txt:SliTnull���     ctxt� o      �Z�Z 0 thetext theText� �Y��
�Y 
Idx1� |�X�W��V��X  �W  � o      �U�U 0 
startindex 
startIndex�V  � m      �T�T � �S��R
�S 
Idx2� |�Q�P��O��Q  �P  � o      �N�N 0 endindex endIndex�O  � d      �� m      �M�M �R  � Q     k���� k    Y�� ��� r    ��� n   ��� I    �L��K�L "0 astextparameter asTextParameter� ��� o    	�J�J 0 thetext theText� ��I� m   	 
�� ���  �I  �K  � o    �H�H 0 _supportlib _supportLib� o      �G�G 0 thetext theText� ��� l   ���� Z   ���F�E� =    ��� n   ��� 1    �D
�D 
leng� o    �C�C 0 thetext theText� m    �B�B  � L       m     �  �F  �E  �
 caution: testing for `theText is ""` is dependent on current considering/ignoring settings, thus, the only safe ways to check for an empty/non-empty string are to 1. count its characters, or 2. wrap it in a `considering hyphens, punctuation, and white space` block    � �   c a u t i o n :   t e s t i n g   f o r   ` t h e T e x t   i s   " " `   i s   d e p e n d e n t   o n   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s ,   t h u s ,   t h e   o n l y   s a f e   w a y s   t o   c h e c k   f o r   a n   e m p t y / n o n - e m p t y   s t r i n g   a r e   t o   1 .   c o u n t   i t s   c h a r a c t e r s ,   o r   2 .   w r a p   i t   i n   a   ` c o n s i d e r i n g   h y p h e n s ,   p u n c t u a t i o n ,   a n d   w h i t e   s p a c e `   b l o c k  �  l     �A�@�?�A  �@  �?    l     �>	�>   � � TO DO: what if startindex comes after endindex? swap them and return text range as normal, or return empty text? (could even return the specified text range with the characters reversed, but I suspect that won't be helpful)   	 �

�   T O   D O :   w h a t   i f   s t a r t i n d e x   c o m e s   a f t e r   e n d i n d e x ?   s w a p   t h e m   a n d   r e t u r n   t e x t   r a n g e   a s   n o r m a l ,   o r   r e t u r n   e m p t y   t e x t ?   ( c o u l d   e v e n   r e t u r n   t h e   s p e c i f i e d   t e x t   r a n g e   w i t h   t h e   c h a r a c t e r s   r e v e r s e d ,   b u t   I   s u s p e c t   t h a t   w o n ' t   b e   h e l p f u l )  l     �=�<�;�=  �<  �;    l     �:�:   � � TO DO: if the entire slice is out of range (i.e. *both* indexes are before or after the first/last character) then need to return "" (currently, because of how it pins, it'll return a single character instead, which is incorrect)    ��   T O   D O :   i f   t h e   e n t i r e   s l i c e   i s   o u t   o f   r a n g e   ( i . e .   * b o t h *   i n d e x e s   a r e   b e f o r e   o r   a f t e r   t h e   f i r s t / l a s t   c h a r a c t e r )   t h e n   n e e d   t o   r e t u r n   " "   ( c u r r e n t l y ,   b e c a u s e   o f   h o w   i t   p i n s ,   i t ' l l   r e t u r n   a   s i n g l e   c h a r a c t e r   i n s t e a d ,   w h i c h   i s   i n c o r r e c t )  r     5 I     3�9�8�9 0 	_pinindex 	_pinIndex  n  ! , I   & ,�7�6�7 (0 asintegerparameter asIntegerParameter  o   & '�5�5 0 
startindex 
startIndex �4 m   ' ( �    f r o m�4  �6   o   ! &�3�3 0 _supportlib _supportLib !�2! n   , /"#" 1   - /�1
�1 
leng# o   , -�0�0 0 thetext theText�2  �8   o      �/�/ 0 
startindex 
startIndex $%$ r   6 K&'& I   6 I�.(�-�. 0 	_pinindex 	_pinIndex( )*) n  7 B+,+ I   < B�,-�+�, (0 asintegerparameter asIntegerParameter- ./. o   < =�*�* 0 endindex endIndex/ 0�)0 m   = >11 �22  t o�)  �+  , o   7 <�(�( 0 _supportlib _supportLib* 3�'3 n   B E454 1   C E�&
�& 
leng5 o   B C�%�% 0 thetext theText�'  �-  ' o      �$�$ 0 endindex endIndex% 6�#6 L   L Y77 n   L X898 7  M W�":;
�" 
ctxt: o   Q S�!�! 0 
startindex 
startIndex; o   T V� �  0 endindex endIndex9 o   L M�� 0 thetext theText�#  � R      �<=
� .ascrerr ****      � ****< o      �� 0 etext eText= �>?
� 
errn> o      �� 0 enumber eNumber? �@A
� 
erob@ o      �� 0 efrom eFromA �B�
� 
errtB o      �� 
0 eto eTo�  � I   a k�C�� 
0 _error  C DED m   b cFF �GG  s l i c e   t e x tE HIH o   c d�� 0 etext eTextI JKJ o   d e�� 0 enumber eNumberK LML o   e f�� 0 efrom eFromM N�N o   f g�� 
0 eto eTo�  �  � OPO l     ����  �  �  P QRQ l     ��
�	�  �
  �	  R STS i  _ bUVU I     �WX
� .Txt:TrmTnull���     ctxtW o      �� 0 thetext theTextX �Y�
� 
FromY |��Z�[�  �  Z o      �� 0 whichend whichEnd�  [ l     \� ��\ m      ��
�� TrFTTrSE�   ��  �  V Q     �]^_] k    �`` aba r    cdc n   efe I    ��g���� "0 astextparameter asTextParameterg hih o    	���� 0 thetext theTexti j��j m   	 
kk �ll  ��  ��  f o    ���� 0 _supportlib _supportLibd o      ���� 0 thetext theTextb mnm Z    ,op����o H    qq E   rsr J    tt uvu m    ��
�� TrFTTrFSv wxw m    ��
�� TrFTTrFEx y��y m    ��
�� TrFTTrSE��  s J    zz {��{ o    ���� 0 whichend whichEnd��  p R    (��|}
�� .ascrerr ****      � ****| m   & '~~ � n I n v a l i d    r e m o v i n g    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .} ����
�� 
errn� m     !�����Y� ����
�� 
erob� o   " #���� 0 whichend whichEnd� �����
�� 
errt� m   $ %��
�� 
enum��  ��  ��  n ���� P   - ����� k   2 ��� ��� l  2 >���� Z  2 >������� =  2 5��� o   2 3���� 0 thetext theText� m   3 4�� ���  � L   8 :�� m   8 9�� ���  ��  ��  � H B check if theText is empty or contains white space characters only   � ��� �   c h e c k   i f   t h e T e x t   i s   e m p t y   o r   c o n t a i n s   w h i t e   s p a c e   c h a r a c t e r s   o n l y� ��� r   ? V��� J   ? C�� ��� m   ? @���� � ���� m   @ A��������  � J      �� ��� o      ���� 0 
startindex 
startIndex� ���� o      ���� 0 endindex endIndex��  � ��� Z   W ������� E  W _��� J   W [�� ��� m   W X��
�� TrFTTrFS� ���� m   X Y��
�� TrFTTrSE��  � J   [ ^�� ���� o   [ \���� 0 whichend whichEnd��  � V   b {��� r   q v��� [   q t��� o   q r���� 0 
startindex 
startIndex� m   r s���� � o      ���� 0 
startindex 
startIndex� =  f p��� n   f l��� 4   g l���
�� 
cha � o   j k���� 0 
startindex 
startIndex� o   f g���� 0 thetext theText� m   l o�� ���  ��  ��  � ��� Z   � �������� E  � ���� J   � ��� ��� m   � ���
�� TrFTTrFE� ���� m   � ���
�� TrFTTrSE��  � J   � ��� ���� o   � ����� 0 whichend whichEnd��  � V   � ���� r   � ���� \   � ���� o   � ����� 0 endindex endIndex� m   � ����� � o      ���� 0 endindex endIndex� =  � ���� n   � ���� 4   � ����
�� 
cha � o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText� m   � ��� ���  ��  ��  � ���� L   � ��� n   � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText��  � ���
�� conscase� ���
�� consdiac� ���
�� consnume� ���
�� conshyph� ����
�� conspunc��  � ����
�� conswhit��  ��  ^ R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  _ I   � �������� 
0 _error  � ��� m   � ��� ���  t r i m   t e x t� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��  T ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ��� ��  �   Split and Join Suite     � *   S p l i t   a n d   J o i n   S u i t e�  l     ��������  ��  ��    i  c f I      ������ 0 
_splittext 
_splitText 	
	 o      ���� 0 thetext theText
 �� o      ���� 0 theseparator theSeparator��  ��   l    ^ k     ^  r      n    
 I    
������ "0 aslistparameter asListParameter �� o    ���� 0 theseparator theSeparator��  ��   o     ���� 0 _supportlib _supportLib o      ���� 0 delimiterlist delimiterList  X    C�� Q    > l    ) ! r     )"#" c     %$%$ n     #&'& 1   ! #��
�� 
pcnt' o     !���� 0 aref aRef% m   # $��
�� 
ctxt# n      ()( 1   & (��
�� 
pcnt) o   % &���� 0 aref aRef �� caution: AS silently ignores invalid TID values, so separator items must be explicitly validated to catch any user errors; for now, just coerce to text and catch errors, but might want to make it more rigorous in future (e.g. if a list of lists is given, should sublist be treated as an error instead of just coercing it to text, which is itself TIDs sensitive); see also existing TODO on LibrarySupportLib's asTextParameter handler   ! �**b   c a u t i o n :   A S   s i l e n t l y   i g n o r e s   i n v a l i d   T I D   v a l u e s ,   s o   s e p a r a t o r   i t e m s   m u s t   b e   e x p l i c i t l y   v a l i d a t e d   t o   c a t c h   a n y   u s e r   e r r o r s ;   f o r   n o w ,   j u s t   c o e r c e   t o   t e x t   a n d   c a t c h   e r r o r s ,   b u t   m i g h t   w a n t   t o   m a k e   i t   m o r e   r i g o r o u s   i n   f u t u r e   ( e . g .   i f   a   l i s t   o f   l i s t s   i s   g i v e n ,   s h o u l d   s u b l i s t   b e   t r e a t e d   a s   a n   e r r o r   i n s t e a d   o f   j u s t   c o e r c i n g   i t   t o   t e x t ,   w h i c h   i s   i t s e l f   T I D s   s e n s i t i v e ) ;   s e e   a l s o   e x i s t i n g   T O D O   o n   L i b r a r y S u p p o r t L i b ' s   a s T e x t P a r a m e t e r   h a n d l e r R      ����+
�� .ascrerr ****      � ****��  + ��,��
�� 
errn, d      -- m      �������   l  1 >./0. n  1 >121 I   6 >��3���� 60 throwinvalidparametertype throwInvalidParameterType3 454 o   6 7���� 0 theseparator theSeparator5 676 m   7 888 �99  u s i n g   s e p a r a t o r7 :;: m   8 9<< �==  l i s t   o f   t e x t; >��> m   9 :��
�� 
list��  ��  2 o   1 6���� 0 _supportlib _supportLib/ � TO DO: would it be better to return a reference to the invalid item rather than the entire list? note that ListLib uses `a ref to item INDEX of LIST` for `eFrom`, which makes the problem value obvious (also, what to use for `eTo` as `list` is vague?)   0 �??�   T O   D O :   w o u l d   i t   b e   b e t t e r   t o   r e t u r n   a   r e f e r e n c e   t o   t h e   i n v a l i d   i t e m   r a t h e r   t h a n   t h e   e n t i r e   l i s t ?   n o t e   t h a t   L i s t L i b   u s e s   ` a   r e f   t o   i t e m   I N D E X   o f   L I S T `   f o r   ` e F r o m ` ,   w h i c h   m a k e s   t h e   p r o b l e m   v a l u e   o b v i o u s   ( a l s o ,   w h a t   t o   u s e   f o r   ` e T o `   a s   ` l i s t `   i s   v a g u e ? )�� 0 aref aRef o    �� 0 delimiterlist delimiterList @A@ r   D IBCB n  D GDED 1   E G�~
�~ 
txdlE 1   D E�}
�} 
ascrC o      �|�| 0 oldtids oldTIDsA FGF r   J OHIH o   J K�{�{ 0 delimiterlist delimiterListI n     JKJ 1   L N�z
�z 
txdlK 1   K L�y
�y 
ascrG LML r   P UNON n   P SPQP 2  Q S�x
�x 
citmQ o   P Q�w�w 0 thetext theTextO o      �v�v 0 
resultlist 
resultListM RSR r   V [TUT o   V W�u�u 0 oldtids oldTIDsU n     VWV 1   X Z�t
�t 
txdlW 1   W X�s
�s 
ascrS X�rX L   \ ^YY o   \ ]�q�q 0 
resultlist 
resultList�r   � � used by `split text` to split text using one or more text item delimiters and current or predefined considering/ignoring settings    �ZZ   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   o n e   o r   m o r e   t e x t   i t e m   d e l i m i t e r s   a n d   c u r r e n t   o r   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s [\[ l     �p�o�n�p  �o  �n  \ ]^] l     �m�l�k�m  �l  �k  ^ _`_ i  g jaba I      �jc�i�j 0 _splitpattern _splitPatternc ded o      �h�h 0 thetext theTexte f�gf o      �f�f 0 patterntext patternText�g  �i  b l    �ghig k     �jj klk r     mnm I     �eo�d�e 60 _compileregularexpression _compileRegularExpressiono p�cp o    �b�b 0 patterntext patternText�c  �d  n o      �a�a 
0 regexp  l qrq r   	 sts n  	 uvu I    �`w�_�` &0 stringwithstring_ stringWithString_w x�^x o    �]�] 0 thetext theText�^  �_  v n  	 yzy o   
 �\�\ 0 nsstring NSStringz m   	 
�[
�[ misccurat o      �Z�Z 0 
asocstring 
asocStringr {|{ l   }~} r    ��� m    �Y�Y  � o      �X�X &0 asocnonmatchstart asocNonMatchStart~ G A used to calculate NSRanges for non-matching portions of NSString    ��� �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n g| ��� r    ��� J    �W�W  � o      �V�V 0 
resultlist 
resultList� ��� l   �U���U  � @ : iterate over each non-matched + matched range in NSString   � ��� t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g� ��� r    .��� n   ,��� I    ,�T��S�T @0 matchesinstring_options_range_ matchesInString_options_range_� ��� o    �R�R 0 
asocstring 
asocString� ��� m     �Q�Q  � ��P� J     (�� ��� m     !�O�O  � ��N� n  ! &��� I   " &�M�L�K�M 
0 length  �L  �K  � o   ! "�J�J 0 
asocstring 
asocString�N  �P  �S  � o    �I�I 
0 regexp  � o      �H�H  0 asocmatcharray asocMatchArray� ��� Y   / v��G���F� k   ? q�� ��� r   ? L��� l  ? J��E�D� n  ? J��� I   E J�C��B�C 0 rangeatindex_ rangeAtIndex_� ��A� m   E F�@�@  �A  �B  � l  ? E��?�>� n  ? E��� I   @ E�=��<�=  0 objectatindex_ objectAtIndex_� ��;� o   @ A�:�: 0 i  �;  �<  � o   ? @�9�9  0 asocmatcharray asocMatchArray�?  �>  �E  �D  � o      �8�8  0 asocmatchrange asocMatchRange� ��� r   M T��� n  M R��� I   N R�7�6�5�7 0 location  �6  �5  � o   M N�4�4  0 asocmatchrange asocMatchRange� o      �3�3  0 asocmatchstart asocMatchStart� ��� r   U g��� c   U d��� l  U b��2�1� n  U b��� I   V b�0��/�0 *0 substringwithrange_ substringWithRange_� ��.� K   V ^�� �-���- 0 location  � o   W X�,�, &0 asocnonmatchstart asocNonMatchStart� �+��*�+ 
0 length  � \   Y \��� o   Y Z�)�)  0 asocmatchstart asocMatchStart� o   Z [�(�( &0 asocnonmatchstart asocNonMatchStart�*  �.  �/  � o   U V�'�' 0 
asocstring 
asocString�2  �1  � m   b c�&
�& 
ctxt� n      ���  ;   e f� o   d e�%�% 0 
resultlist 
resultList� ��$� r   h q��� [   h o��� o   h i�#�#  0 asocmatchstart asocMatchStart� l  i n��"�!� n  i n��� I   j n� ���  
0 length  �  �  � o   i j��  0 asocmatchrange asocMatchRange�"  �!  � o      �� &0 asocnonmatchstart asocNonMatchStart�$  �G 0 i  � m   2 3��  � \   3 :��� l  3 8���� n  3 8��� I   4 8���� 	0 count  �  �  � o   3 4��  0 asocmatcharray asocMatchArray�  �  � m   8 9�� �F  � ��� l  w w����  � "  add final non-matched range   � ��� 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e� ��� r   w ���� c   w ��� l  w }���� n  w }��� I   x }���� *0 substringfromindex_ substringFromIndex_� ��� o   x y�� &0 asocnonmatchstart asocNonMatchStart�  �  � o   w x�� 0 
asocstring 
asocString�  �  � m   } ~�
� 
ctxt� n      ���  ;   � �� o    ��
�
 0 
resultlist 
resultList� ��	� L   � ��� o   � ��� 0 
resultlist 
resultList�	  h Q K used by `split text` to split text using a regular expression as separator   i ��� �   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   a   r e g u l a r   e x p r e s s i o n   a s   s e p a r a t o r` ��� l     ����  �  �  � ��� l     ����  �  �  � ��� i  k n��� I      ��� � 0 	_jointext 	_joinText� ��� o      ���� 0 thelist theList� ���� o      ���� 0 separatortext separatorText��  �   � k     >�� ��� r     ��� n    ��� 1    ��
�� 
txdl� 1     ��
�� 
ascr� o      ���� 0 oldtids oldTIDs� 	 		  r    			 o    ���� 0 delimiterlist delimiterList	 n     			 1    
��
�� 
txdl	 1    ��
�� 
ascr	 			 Q    5				
	 r    			 c    			 n   			 I    ��	���� "0 aslistparameter asListParameter	 	��	 o    ���� 0 thelist theList��  ��  	 o    ���� 0 _supportlib _supportLib	 m    ��
�� 
ctxt	 o      ���� 0 
resulttext 
resultText		 R      ����	
�� .ascrerr ****      � ****��  	 ��	��
�� 
errn	 d      		 m      �������  	
 k   % 5		 			 r   % *			 o   % &���� 0 oldtids oldTIDs	 n     			 1   ' )��
�� 
txdl	 1   & '��
�� 
ascr	 	��	 R   + 5��		
�� .ascrerr ****      � ****	 m   3 4	 	  �	!	! b I n v a l i d   d i r e c t   p a r a m e t e r   ( e x p e c t e d   l i s t   o f   t e x t ) .	 ��	"	#
�� 
errn	" m   - .�����Y	# ��	$	%
�� 
erob	$ o   / 0���� 0 thelist theList	% ��	&��
�� 
errt	& m   1 2��
�� 
list��  ��  	 	'	(	' r   6 ;	)	*	) o   6 7���� 0 oldtids oldTIDs	* n     	+	,	+ 1   8 :��
�� 
txdl	, 1   7 8��
�� 
ascr	( 	-��	- L   < >	.	. o   < =���� 0 
resulttext 
resultText��  � 	/	0	/ l     ��������  ��  ��  	0 	1	2	1 l     ��������  ��  ��  	2 	3	4	3 l     ��	5	6��  	5  -----   	6 �	7	7 
 - - - - -	4 	8	9	8 l     ��������  ��  ��  	9 	:	;	: i  o r	<	=	< I     ��	>	?
�� .Txt:SplTnull���     ctxt	> o      ���� 0 thetext theText	? ��	@	A
�� 
Sepa	@ |����	B��	C��  ��  	B o      ���� 0 theseparator theSeparator��  	C l     	D����	D m      ��
�� 
msng��  ��  	A ��	E��
�� 
Usin	E |����	F��	G��  ��  	F o      ���� 0 matchformat matchFormat��  	G l     	H����	H m      ��
�� SerECmpI��  ��  ��  	= k     �	I	I 	J	K	J l     ��	L	M��  	Lrl convenience handler for splitting text using TIDs that can also use a regular expression pattern as separator; note that this is similar to using `search text theText for theSeparator returning non matching text` (except that `search text` returns start and end indexes as well as text), but avoids some of the overhead and is an obvious complement to `join text`   	M �	N	N�   c o n v e n i e n c e   h a n d l e r   f o r   s p l i t t i n g   t e x t   u s i n g   T I D s   t h a t   c a n   a l s o   u s e   a   r e g u l a r   e x p r e s s i o n   p a t t e r n   a s   s e p a r a t o r ;   n o t e   t h a t   t h i s   i s   s i m i l a r   t o   u s i n g   ` s e a r c h   t e x t   t h e T e x t   f o r   t h e S e p a r a t o r   r e t u r n i n g   n o n   m a t c h i n g   t e x t `   ( e x c e p t   t h a t   ` s e a r c h   t e x t `   r e t u r n s   s t a r t   a n d   e n d   i n d e x e s   a s   w e l l   a s   t e x t ) ,   b u t   a v o i d s   s o m e   o f   t h e   o v e r h e a d   a n d   i s   a n   o b v i o u s   c o m p l e m e n t   t o   ` j o i n   t e x t `	K 	O��	O Q     �	P	Q	R	P k    �	S	S 	T	U	T r    	V	W	V n   	X	Y	X I    ��	Z���� "0 astextparameter asTextParameter	Z 	[	\	[ o    	���� 0 thetext theText	\ 	]��	] m   	 
	^	^ �	_	_  ��  ��  	Y o    ���� 0 _supportlib _supportLib	W o      ���� 0 thetext theText	U 	`��	` Z    �	a	b	c	d	a =   	e	f	e o    ���� 0 theseparator theSeparator	f m    ��
�� 
msng	b l   	g	h	i	g L    	j	j I    ��	k���� 0 _splitpattern _splitPattern	k 	l	m	l o    ���� 0 thetext theText	m 	n��	n m    	o	o �	p	p  \ s +��  ��  	h g a if `at` parameter is omitted, splits on whitespace runs by default, ignoring any `using` options   	i �	q	q �   i f   ` a t `   p a r a m e t e r   i s   o m i t t e d ,   s p l i t s   o n   w h i t e s p a c e   r u n s   b y   d e f a u l t ,   i g n o r i n g   a n y   ` u s i n g `   o p t i o n s	c 	r	s	r =  " %	t	u	t o   " #���� 0 matchformat matchFormat	u m   # $��
�� SerECmpI	s 	v	w	v P   ( 6	x	y	z	x L   - 5	{	{ I   - 4��	|���� 0 
_splittext 
_splitText	| 	}	~	} o   . /���� 0 thetext theText	~ 	��	 o   / 0���� 0 theseparator theSeparator��  ��  	y ��	�
�� consdiac	� ��	�
�� conshyph	� ��	�
�� conspunc	� ��	�
�� conswhit	� ����
�� consnume��  	z ����
�� conscase��  	w 	�	�	� =  9 <	�	�	� o   9 :���� 0 matchformat matchFormat	� m   : ;��
�� SerECmpP	� 	�	�	� L   ? Q	�	� I   ? P��	����� 0 _splitpattern _splitPattern	� 	�	�	� o   @ A���� 0 thetext theText	� 	���	� n  A L	�	�	� I   F L��	����� "0 astextparameter asTextParameter	� 	�	�	� o   F G���� 0 theseparator theSeparator	� 	���	� m   G H	�	� �	�	�  a t��  ��  	� o   A F���� 0 _supportlib _supportLib��  ��  	� 	�	�	� =  T W	�	�	� o   T U���� 0 matchformat matchFormat	� m   U V��
�� SerECmpC	� 	�	�	� P   Z h	�	���	� L   _ g	�	� I   _ f��	����� 0 
_splittext 
_splitText	� 	�	�	� o   ` a���� 0 thetext theText	� 	���	� o   a b���� 0 theseparator theSeparator��  ��  	� ��	�
�� conscase	� ��	�
�� consdiac	� ��	�
�� conshyph	� ��	�
�� conspunc	� ��	�
�� conswhit	� ����
�� consnume��  ��  	� 	�	�	� =  k n	�	�	� o   k l���� 0 matchformat matchFormat	� m   l m��
�� SerECmpD	� 	���	� L   q y	�	� I   q x��	����� 0 
_splittext 
_splitText	� 	�	�	� o   r s�� 0 thetext theText	� 	��~	� o   s t�}�} 0 theseparator theSeparator�~  ��  ��  	d R   | ��|	�	�
�| .ascrerr ****      � ****	� m   � �	�	� �	�	� h I n v a l i d    u s i n g    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .	� �{	�	�
�{ 
errn	� m   ~ �z�z�Y	� �y	�	�
�y 
erob	� o   � ��x�x 0 matchformat matchFormat	� �w	��v
�w 
errt	� m   � ��u
�u 
enum�v  ��  	Q R      �t	�	�
�t .ascrerr ****      � ****	� o      �s�s 0 etext eText	� �r	�	�
�r 
errn	� o      �q�q 0 enumber eNumber	� �p	�	�
�p 
erob	� o      �o�o 0 efrom eFrom	� �n	��m
�n 
errt	� o      �l�l 
0 eto eTo�m  	R I   � ��k	��j�k 
0 _error  	� 	�	�	� m   � �	�	� �	�	�  s p l i t   t e x t	� 	�	�	� o   � ��i�i 0 etext eText	� 	�	�	� o   � ��h�h 0 enumber eNumber	� 	�	�	� o   � ��g�g 0 efrom eFrom	� 	��f	� o   � ��e�e 
0 eto eTo�f  �j  ��  	; 	�	�	� l     �d�c�b�d  �c  �b  	� 	�	�	� l     �a�`�_�a  �`  �_  	� 	�	�	� i  s v	�	�	� I     �^	�	�
�^ .Txt:JoiTnull���     ****	� o      �]�] 0 thelist theList	� �\	��[
�\ 
Sepa	� |�Z�Y	��X	��Z  �Y  	� o      �W�W 0 separatortext separatorText�X  	� m      	�	� �	�	�  �[  	� Q     '	�	�	�	� L    	�	� I    �V	��U�V 0 	_jointext 	_joinText	� 	�	�	� o    �T�T 0 thelist theList	� 	��S	� n   	�	�	� I   
 �R	��Q�R "0 astextparameter asTextParameter	� 	�	�	� o   
 �P�P 0 separatortext separatorText	� 	��O	� m    	�	� �	�	�  u s i n g   s e p a r a t o r�O  �Q  	� o    
�N�N 0 _supportlib _supportLib�S  �U  	� R      �M	�	�
�M .ascrerr ****      � ****	� o      �L�L 0 etext eText	� �K	�	�
�K 
errn	� o      �J�J 0 enumber eNumber	� �I	�	�
�I 
erob	� o      �H�H 0 efrom eFrom	� �G	��F
�G 
errt	� o      �E�E 
0 eto eTo�F  	� I    '�D	��C�D 
0 _error  	� 	�	�	� m    	�	� �	�	�  j o i n   t e x t	� 	�	�	� o     �B�B 0 etext eText	� 	�	�	� o     !�A�A 0 enumber eNumber	� 	�	�	� o   ! "�@�@ 0 efrom eFrom	� 
 �?
  o   " #�>�> 
0 eto eTo�?  �C  	� 


 l     �=�<�;�=  �<  �;  
 


 l     �:�9�8�:  �9  �8  
 


 i  w z


 I     �7
	�6
�7 .Txt:SplPnull���     ctxt
	 o      �5�5 0 thetext theText�6  
 Q     $





 L    

 n    


 2   �4
�4 
cpar
 n   


 I    �3
�2�3 "0 astextparameter asTextParameter
 


 o    	�1�1 0 thetext theText
 
�0
 m   	 


 �

  �0  �2  
 o    �/�/ 0 _supportlib _supportLib
 R      �.


�. .ascrerr ****      � ****
 o      �-�- 0 etext eText
 �,


�, 
errn
 o      �+�+ 0 enumber eNumber
 �*


�* 
erob
 o      �)�) 0 efrom eFrom
 �(
�'
�( 
errt
 o      �&�& 
0 eto eTo�'  
 I    $�%
�$�% 
0 _error  
 
 
!
  m    
"
" �
#
#   s p l i t   p a r a g r a p h s
! 
$
%
$ o    �#�# 0 etext eText
% 
&
'
& o    �"�" 0 enumber eNumber
' 
(
)
( o    �!�! 0 efrom eFrom
) 
*� 
* o     �� 
0 eto eTo�   �$  
 
+
,
+ l     ����  �  �  
, 
-
.
- l     ����  �  �  
. 
/
0
/ i  { ~
1
2
1 I     �
3
4
� .Txt:JoiPnull���     ****
3 o      �� 0 thelist theList
4 �
5�
� 
LiBr
5 |��
6�
7�  �  
6 o      �� 0 linebreaktype lineBreakType�  
7 l     
8��
8 m      �
� LiBrLiOX�  �  �  
2 Q     P
9
:
;
9 k    <
<
< 
=
>
= Z    3
?
@
A
B
? =   
C
D
C o    �� 0 linebreaktype lineBreakType
D m    �
� LiBrLiOX
@ r   	 
E
F
E 1   	 
�
� 
lnfd
F o      �
�
 0 separatortext separatorText
A 
G
H
G =   
I
J
I o    �	�	 0 linebreaktype lineBreakType
J m    �
� LiBrLiCM
H 
K
L
K r    
M
N
M o    �
� 
ret 
N o      �� 0 separatortext separatorText
L 
O
P
O =   
Q
R
Q o    �� 0 linebreaktype lineBreakType
R m    �
� LiBrLiWi
P 
S�
S r   ! &
T
U
T b   ! $
V
W
V o   ! "�
� 
ret 
W 1   " #�
� 
lnfd
U o      � �  0 separatortext separatorText�  
B R   ) 3��
X
Y
�� .ascrerr ****      � ****
X m   1 2
Z
Z �
[
[ h I n v a l i d    u s i n g    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .
Y ��
\
]
�� 
errn
\ m   + ,�����Y
] ��
^
_
�� 
erob
^ o   - .���� 0 linebreaktype lineBreakType
_ ��
`��
�� 
errt
` m   / 0��
�� 
enum��  
> 
a��
a L   4 <
b
b I   4 ;��
c���� 0 	_jointext 	_joinText
c 
d
e
d o   5 6���� 0 thelist theList
e 
f��
f o   6 7���� 0 separatortext separatorText��  ��  ��  
: R      ��
g
h
�� .ascrerr ****      � ****
g o      ���� 0 etext eText
h ��
i
j
�� 
errn
i o      ���� 0 enumber eNumber
j ��
k
l
�� 
erob
k o      ���� 0 efrom eFrom
l ��
m��
�� 
errt
m o      ���� 
0 eto eTo��  
; I   D P��
n���� 
0 _error  
n 
o
p
o m   E F
q
q �
r
r  j o i n   p a r a g r a p h s
p 
s
t
s o   F G���� 0 etext eText
t 
u
v
u o   G H���� 0 enumber eNumber
v 
w
x
w o   H I���� 0 efrom eFrom
x 
y��
y o   I J���� 
0 eto eTo��  ��  
0 
z
{
z l     ��������  ��  ��  
{ 
|
}
| l     ��������  ��  ��  
} 
~��
~ l     ��������  ��  ��  ��        ��

�������
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
���  
 ������������������������������������������������������������
�� 
pimr�� (0 _unmatchedtexttype _UnmatchedTextType�� $0 _matchedtexttype _MatchedTextType�� &0 _matchedgrouptype _MatchedGroupType�� 0 _supportlib _supportLib�� 
0 _error  �� 60 _compileregularexpression _compileRegularExpression�� $0 _matchinforecord _matchInfoRecord�� 0 _matchrecords _matchRecords�� &0 _matchedgrouplist _matchedGroupList�� 0 _findpattern _findPattern�� "0 _replacepattern _replacePattern�� 0 	_findtext 	_findText�� 0 _replacetext _replaceText
�� .Txt:Srchnull���     ctxt
�� .Txt:EPatnull���     ctxt
�� .Txt:ETemnull���     ctxt�� 0 	_pinindex 	_pinIndex
�� .Txt:UppTnull���     ctxt
�� .Txt:CapTnull���     ctxt
�� .Txt:LowTnull���     ctxt
�� .Txt:SliTnull���     ctxt
�� .Txt:TrmTnull���     ctxt�� 0 
_splittext 
_splitText�� 0 _splitpattern _splitPattern�� 0 	_jointext 	_joinText
�� .Txt:SplTnull���     ctxt
�� .Txt:JoiTnull���     ****
�� .Txt:SplPnull���     ctxt
�� .Txt:JoiPnull���     ****
� ��
��� 
�  
�
� ��
���
�� 
cobj
� 
�
�   �� 
�� 
frmk��  
�� 
TxtU
�� 
TxtM
�� 
TxtG
� 
�
�   �� A
�� 
scpt
� �� K����
�
����� 
0 _error  �� ��
��� 
�  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  
� ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
�  [������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ 
� �� y����
�
����� 60 _compileregularexpression _compileRegularExpression�� ��
��� 
�  ���� 0 patterntext patternText��  
� �������� 0 patterntext patternText�� 0 err  �� 
0 regexp  
� 
������������������ �
�� 
msng
�� misccura�� *0 nsregularexpression NSRegularExpression
�� 
cobj�� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_
�� 
errn���Y
�� 
erob�� �� -�kvE�O��,�j��k/m+ E�O��  )�����Y hO�
� �� �����
�
����� $0 _matchinforecord _matchInfoRecord�� ��
��� 
�  ���������� 0 
asocstring 
asocString��  0 asocmatchrange asocMatchRange�� 0 
textoffset 
textOffset�� 0 
recordtype 
recordType��  
� ������������� 0 
asocstring 
asocString��  0 asocmatchrange asocMatchRange�� 0 
textoffset 
textOffset�� 0 
recordtype 
recordType�� 0 	foundtext 	foundText�  0 nexttextoffset nextTextOffset
� �~�}�|�{�z�y�x�w�~ *0 substringwithrange_ substringWithRange_
�} 
ctxt
�| 
leng
�{ 
pcls�z 0 
startindex 
startIndex�y 0 endindex endIndex�x 0 	foundtext 	foundText�w �� $��k+  �&E�O���,E�O���k���lv
� �v ��u�t
�
��s�v 0 _matchrecords _matchRecords�u �r
��r 
�  �q�p�o�n�m�l�q 0 
asocstring 
asocString�p  0 asocmatchrange asocMatchRange�o  0 asocstartindex asocStartIndex�n 0 
textoffset 
textOffset�m (0 nonmatchrecordtype nonMatchRecordType�l "0 matchrecordtype matchRecordType�t  
� �k�j�i�h�g�f�e�d�c�b�a�k 0 
asocstring 
asocString�j  0 asocmatchrange asocMatchRange�i  0 asocstartindex asocStartIndex�h 0 
textoffset 
textOffset�g (0 nonmatchrecordtype nonMatchRecordType�f "0 matchrecordtype matchRecordType�e  0 asocmatchstart asocMatchStart�d 0 asocmatchend asocMatchEnd�c &0 asocnonmatchrange asocNonMatchRange�b 0 nonmatchinfo nonMatchInfo�a 0 	matchinfo 	matchInfo
� �`�_�^�]�\�` 0 location  �_ 
0 length  �^ �] $0 _matchinforecord _matchInfoRecord
�\ 
cobj�s W�j+  E�O��j+ E�O�ᦢ�E�O*�����+ E[�k/E�Z[�l/E�ZO*�����+ E[�k/E�Z[�l/E�ZO�����v
� �[V�Z�Y
�
��X�[ &0 _matchedgrouplist _matchedGroupList�Z �W
��W 
�  �V�U�T�S�V 0 
asocstring 
asocString�U 0 	asocmatch 	asocMatch�T 0 
textoffset 
textOffset�S &0 includenonmatches includeNonMatches�Y  
� �R�Q�P�O�N�M�L�K�J�I�H�G�F�R 0 
asocstring 
asocString�Q 0 	asocmatch 	asocMatch�P 0 
textoffset 
textOffset�O &0 includenonmatches includeNonMatches�N "0 submatchresults subMatchResults�M 0 groupindexes groupIndexes�L (0 asocfullmatchrange asocFullMatchRange�K &0 asocnonmatchstart asocNonMatchStart�J $0 asocfullmatchend asocFullMatchEnd�I 0 i  �H 0 nonmatchinfo nonMatchInfo�G 0 	matchinfo 	matchInfo�F &0 asocnonmatchrange asocNonMatchRange
� 	�E�D�C�B�A�@�?�>�=�E  0 numberofranges numberOfRanges�D 0 rangeatindex_ rangeAtIndex_�C 0 location  �B 
0 length  �A �@ 0 _matchrecords _matchRecords
�? 
cobj�> �= $0 _matchinforecord _matchInfoRecord�X �jvE�O�j+  kE�O�j ��jk+ E�O�j+ E�O��j+ E�O Uk�kh 	*���k+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO��6F[OY��O� #�㨧�E�O*���b  �+ �k/�6FY hY hO�
� �<��;�:
�
��9�< 0 _findpattern _findPattern�; �8
��8 
�  �7�6�5�4�7 0 thetext theText�6 0 patterntext patternText�5 &0 includenonmatches includeNonMatches�4  0 includematches includeMatches�:  
� �3�2�1�0�/�.�-�,�+�*�)�(�'�&�%�3 0 thetext theText�2 0 patterntext patternText�1 &0 includenonmatches includeNonMatches�0  0 includematches includeMatches�/ 
0 regexp  �. 0 
asocstring 
asocString�- &0 asocnonmatchstart asocNonMatchStart�, 0 
textoffset 
textOffset�+ 0 
resultlist 
resultList�*  0 asocmatcharray asocMatchArray�) 0 i  �( 0 	asocmatch 	asocMatch�' 0 nonmatchinfo nonMatchInfo�& 0 	matchinfo 	matchInfo�% 0 	foundtext 	foundText
� ��$�#�"�!� ��������������������$ (0 asbooleanparameter asBooleanParameter�# 60 _compileregularexpression _compileRegularExpression
�" misccura�! 0 nsstring NSString�  &0 stringwithstring_ stringWithString_� 
0 length  � @0 matchesinstring_options_range_ matchesInString_options_range_� 	0 count  �  0 objectatindex_ objectAtIndex_� 0 rangeatindex_ rangeAtIndex_� � 0 _matchrecords _matchRecords
� 
cobj� � 0 foundgroups foundGroups� 0 
startindex 
startIndex� &0 _matchedgrouplist _matchedGroupList� *0 substringfromindex_ substringFromIndex_
� 
ctxt
� 
pcls� 0 endindex endIndex
� 
leng� 0 	foundtext 	foundText� �9b  ��l+ E�Ob  ��l+ E�O*�k+ E�O��,�k+ E�OjE�OkE�OjvE�O��jj�j+ lvm+ E�O j�j+ 	kkh 
��k+ 
E�O*��jk+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO� �a *���a ,��+ l%�6FY h[OY��O� 1��k+ a &E�Oa b  a �a �a ,a �a �6FY hO�
� ����

�
��	� "0 _replacepattern _replacePattern� �
�� 
�  ���� 0 thetext theText� 0 patterntext patternText� 0 templatetext templateText�
  
� ����� � 0 thetext theText� 0 patterntext patternText� 0 templatetext templateText� 0 
asocstring 
asocString�  
0 regexp  
� ��������������
�� misccura�� 0 nsstring NSString�� &0 stringwithstring_ stringWithString_�� 60 _compileregularexpression _compileRegularExpression�� 
0 length  �� �� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_�	 &��,�k+ E�O*�k+ E�O��jj�j+ lv��+ 
� ������
�
����� 0 	_findtext 	_findText�� ��
��� 
�  ���������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches��  
� 
���������������������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches�� 0 
resultlist 
resultList�� 0 oldtids oldTIDs�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 0 i  
� 1��������5����������g������������������
�� 
errn���Y
�� 
erob�� 
�� 
ascr
�� 
txdl
�� 
citm
�� 
leng
�� 
ctxt
�� 
pcls�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 
�� .corecnte****       ****�� 0 foundgroups foundGroups�� 
��(��  )�����Y hOjvE�O��,E�O���,FOkE�O��k/�,E�O�� �[�\[Z�\Z�2E�Y �E�O� �b  ����a �6FY hO �l��-j kh 	�kE�O��,�[�\[�/\Zi2�,E�O�� �[�\[Z�\Z�2E�Y a E�O� �b  ����a jva �6FY hO�kE�O���/�,kE�O�� �[�\[Z�\Z�2E�Y a E�O� �b  ����a �6FY h[OY�XO���,FO�
� ������
�
����� 0 _replacetext _replaceText�� ��
��� 
�  �������� 0 thetext theText�� 0 fortext forText�� 0 newtext newText��  
� �������������� 0 thetext theText�� 0 fortext forText�� 0 newtext newText�� 0 oldtids oldTIDs�� 0 	textitems 	textItems�� 0 
resulttext 
resultText
� ��������
�� 
ascr
�� 
txdl
�� 
citm
�� 
ctxt�� '��,E�O���,FO��-E�O���,FO��&E�O���,FO�
� ��L����
�
���
�� .Txt:Srchnull���     ctxt�� 0 thetext theText�� ����
�
�� 
For_�� 0 fortext forText
� ��
�
�
�� 
Usin
� {�������� 0 matchformat matchFormat��  
�� SerECmpI
� ��
�
�
�� 
Repl
� {�������� 0 newtext newText��  
�� 
msng
� ��
���
�� 
Retu
� {�������� 0 resultformat resultFormat��  
�� RetEMatT��  
� ������������������������ 0 thetext theText�� 0 fortext forText�� 0 matchformat matchFormat�� 0 newtext newText�� 0 resultformat resultFormat�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
� %n��}���������������������������������������� ��5����{��
�������� "0 astextparameter asTextParameter
�� 
leng
�� 
errn���Y
�� 
erob�� 
�� 
msng
�� RetEMatT
�� 
cobj
�� RetEUmaT
�� RetEAllT
�� 
errt
�� 
enum�� 
�� SerECmpI�� 0 	_findtext 	_findText
�� SerECmpP�� 0 _findpattern _findPattern
�� SerECmpC
�� SerECmpD�� 0 _replacetext _replaceText�� "0 _replacepattern _replacePattern�� 0 etext eText
� ����
�
�� 
errn�� 0 enumber eNumber
� ����
�
�� 
erob�� 0 efrom eFrom
� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  ����b  ��l+ E�Ob  ��l+ E�O��,j  )�����Y hO��  ܤ�  felvE[�k/E�Z[�l/E�ZY H��  eflvE[�k/E�Z[�l/E�ZY ,��  eelvE[�k/E�Z[�l/E�ZY )�����a a O�a   a a  *�����+ VY W�a   *�����+ Y B�a   a g *�����+ VY %�a   *�����+ Y )�����a a Y �b  �a l+ E�O�a   a a  *���m+ VY T�a   *���m+ Y @�a   a g *���m+ VY $�a   *���m+ Y )�����a a W X   !*a "����a #+ $
� �������
�
���
�� .Txt:EPatnull���     ctxt�� 0 thetext theText��  
� ����~�}�|�� 0 thetext theText� 0 etext eText�~ 0 enumber eNumber�} 0 efrom eFrom�| 
0 eto eTo
� �{�z��y�x�w�v
���u�t
�{ misccura�z *0 nsregularexpression NSRegularExpression�y "0 astextparameter asTextParameter�x 40 escapedpatternforstring_ escapedPatternForString_
�w 
ctxt�v 0 etext eText
� �s�r
�
�s 
errn�r 0 enumber eNumber
� �q�p
�
�q 
erob�p 0 efrom eFrom
� �o�n�m
�o 
errt�n 
0 eto eTo�m  �u �t 
0 _error  �� + ��,b  ��l+ k+ �&W X  *衢���+ 

� �l��k�j
�
��i
�l .Txt:ETemnull���     ctxt�k 0 thetext theText�j  
� �h�g�f�e�d�h 0 thetext theText�g 0 etext eText�f 0 enumber eNumber�e 0 efrom eFrom�d 
0 eto eTo
� �c�b��a�`�_�^
���]�\
�c misccura�b *0 nsregularexpression NSRegularExpression�a "0 astextparameter asTextParameter�` 60 escapedtemplateforstring_ escapedTemplateForString_
�_ 
ctxt�^ 0 etext eText
� �[�Z
�
�[ 
errn�Z 0 enumber eNumber
� �Y�X
�
�Y 
erob�X 0 efrom eFrom
� �W�V�U
�W 
errt�V 
0 eto eTo�U  �] �\ 
0 _error  �i + ��,b  ��l+ k+ �&W X  *衢���+ 

� �T�S�R
�
��Q�T 0 	_pinindex 	_pinIndex�S �P
��P 
�  �O�N�O 0 theindex theIndex�N 0 
textlength 
textLength�R  
� �M�L�M 0 theindex theIndex�L 0 
textlength 
textLength
�  �Q &�� �Y ��' �'Y �j  kY �
� �K;�J�I
�
��H
�K .Txt:UppTnull���     ctxt�J 0 thetext theText�I  
� �G�F�E�D�C�G 0 thetext theText�F 0 etext eText�E 0 enumber eNumber�D 0 efrom eFrom�C 
0 eto eTo
� �B�AR�@�?�>�=�<
�`�;�:
�B misccura�A 0 nsstring NSString�@ "0 astextparameter asTextParameter�? &0 stringwithstring_ stringWithString_�> "0 lowercasestring lowercaseString
�= 
ctxt�< 0 etext eText
� �9�8
�
�9 
errn�8 0 enumber eNumber
� �7�6
�
�7 
erob�6 0 efrom eFrom
� �5�4�3
�5 
errt�4 
0 eto eTo�3  �; �: 
0 _error  �H / ��,b  ��l+ k+ j+ �&W X  *顢���+ 
� �2p�1�0
�
��/
�2 .Txt:CapTnull���     ctxt�1 0 thetext theText�0  
� �.�-�,�+�*�. 0 thetext theText�- 0 etext eText�, 0 enumber eNumber�+ 0 efrom eFrom�* 
0 eto eTo
� �)�(��'�&�%�$�#
���"�!
�) misccura�( 0 nsstring NSString�' "0 astextparameter asTextParameter�& &0 stringwithstring_ stringWithString_�% $0 capitalizestring capitalizeString
�$ 
ctxt�# 0 etext eText
� � �
�
�  
errn� 0 enumber eNumber
� ��
�
� 
erob� 0 efrom eFrom
� ���
� 
errt� 
0 eto eTo�  �" �! 
0 _error  �/ / ��,b  ��l+ k+ j+ �&W X  *顢���+ 
� ����
�
��
� .Txt:LowTnull���     ctxt� 0 thetext theText�  
� ������ 0 thetext theText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo
� ��������

���	�
� misccura� 0 nsstring NSString� "0 astextparameter asTextParameter� &0 stringwithstring_ stringWithString_� "0 lowercasestring lowercaseString
� 
ctxt�
 0 etext eText
� ��
�
� 
errn� 0 enumber eNumber
� ��
�
� 
erob� 0 efrom eFrom
� ���
� 
errt� 
0 eto eTo�  �	 � 
0 _error  � / ��,b  ��l+ k+ j+ �&W X  *顢���+ 
� � �����
�
���
�  .Txt:SliTnull���     ctxt�� 0 thetext theText�� ��
�
�
�� 
Idx1
� {�������� 0 
startindex 
startIndex��  �� 
� ��
���
�� 
Idx2
� {�������� 0 endindex endIndex��  ������  
� ���������������� 0 thetext theText�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
� ���������1����
�F������ "0 astextparameter asTextParameter
�� 
leng�� (0 asintegerparameter asIntegerParameter�� 0 	_pinindex 	_pinIndex
�� 
ctxt�� 0 etext eText
� ����
�
�� 
errn�� 0 enumber eNumber
� ����
�
�� 
erob�� 0 efrom eFrom
� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� l [b  ��l+ E�O��,j  �Y hO*b  ��l+ ��,l+ E�O*b  ��l+ ��,l+ E�O�[�\[Z�\Z�2EW X 	 
*룤���+ 
� ��V����
�
���
�� .Txt:TrmTnull���     ctxt�� 0 thetext theText�� ��
���
�� 
From
� {�������� 0 whichend whichEnd��  
�� TrFTTrSE��  
� ������������������ 0 thetext theText�� 0 whichend whichEnd�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
� k��������������������~��������������
�������� "0 astextparameter asTextParameter
�� TrFTTrFS
�� TrFTTrFE
�� TrFTTrSE
�� 
errn���Y
�� 
erob
�� 
errt
�� 
enum�� 
�� 
cobj
�� 
cha 
�� 
ctxt�� 0 etext eText
� ����
�
�� 
errn�� 0 enumber eNumber
� ����
�
�� 
erob�� 0 efrom eFrom
� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� � �b  ��l+ E�O���mv�kv )�������Y hO�� ���  �Y hOkilvE[a k/E�Z[a l/E�ZO��lv�kv  h�a �/a  �kE�[OY��Y hO��lv�kv  h�a �/a  �kE�[OY��Y hO�[a \[Z�\Z�2EVW X  *a ����a + 
� ������
�
����� 0 
_splittext 
_splitText�� ��
��� 
�  ������ 0 thetext theText�� 0 theseparator theSeparator��  
� �������������� 0 thetext theText�� 0 theseparator theSeparator�� 0 delimiterlist delimiterList�� 0 aref aRef�� 0 oldtids oldTIDs�� 0 
resultlist 
resultList
� ��������������
�8<�������������� "0 aslistparameter asListParameter
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pcnt
�� 
ctxt��  
� ������
�� 
errn���\��  
�� 
list�� �� 60 throwinvalidparametertype throwInvalidParameterType
�� 
ascr
�� 
txdl
�� 
citm�� _b  �k+  E�O 5�[��l kh  ��,�&��,FW X  b  �����+ [OY��O��,E�O���,FO��-E�O���,FO�
� ��b����
�
����� 0 _splitpattern _splitPattern�� ��
��� 
�  ������ 0 thetext theText�� 0 patterntext patternText��  
� 
���������������������� 0 thetext theText�� 0 patterntext patternText�� 
0 regexp  �� 0 
asocstring 
asocString�� &0 asocnonmatchstart asocNonMatchStart�� 0 
resultlist 
resultList��  0 asocmatcharray asocMatchArray�� 0 i  ��  0 asocmatchrange asocMatchRange��  0 asocmatchstart asocMatchStart
� ������������������~�}�|�{�z�� 60 _compileregularexpression _compileRegularExpression
�� misccura�� 0 nsstring NSString�� &0 stringwithstring_ stringWithString_�� 
0 length  �� @0 matchesinstring_options_range_ matchesInString_options_range_�� 	0 count  ��  0 objectatindex_ objectAtIndex_� 0 rangeatindex_ rangeAtIndex_�~ 0 location  �} �| *0 substringwithrange_ substringWithRange_
�{ 
ctxt�z *0 substringfromindex_ substringFromIndex_�� �*�k+  E�O��,�k+ E�OjE�OjvE�O��jj�j+ lvm+ E�O Fj�j+ kkh ��k+ jk+ E�O�j+ 	E�O��䩤�k+ �&�6FO��j+ E�[OY��O��k+ �&�6FO�
� �y��x�w
�
��v�y 0 	_jointext 	_joinText�x �u
��u 
�  �t�s�t 0 thelist theList�s 0 separatortext separatorText�w  
� �r�q�p�o�n�r 0 thelist theList�q 0 separatortext separatorText�p 0 oldtids oldTIDs�o 0 delimiterlist delimiterList�n 0 
resulttext 
resultText
� �m�l�k�j�i
��h�g�f�e�d�c	 
�m 
ascr
�l 
txdl�k "0 aslistparameter asListParameter
�j 
ctxt�i  
� �b�a�`
�b 
errn�a�\�`  
�h 
errn�g�Y
�f 
erob
�e 
errt
�d 
list�c �v ?��,E�O���,FO b  �k+ �&E�W X  ���,FO)�������O���,FO�
� �_	=�^�]
�
��\
�_ .Txt:SplTnull���     ctxt�^ 0 thetext theText�] �[
�
�
�[ 
Sepa
� {�Z�Y�X�Z 0 theseparator theSeparator�Y  
�X 
msng
� �W
��V
�W 
Usin
� {�U�T�S�U 0 matchformat matchFormat�T  
�S SerECmpI�V  
� �R�Q�P�O�N�M�L�R 0 thetext theText�Q 0 theseparator theSeparator�P 0 matchformat matchFormat�O 0 etext eText�N 0 enumber eNumber�M 0 efrom eFrom�L 
0 eto eTo
� 	^�K�J	o�I�H	y	z�G�F	��E	��D�C�B�A�@�?�>	��= 	��<�;�K "0 astextparameter asTextParameter
�J 
msng�I 0 _splitpattern _splitPattern
�H SerECmpI�G 0 
_splittext 
_splitText
�F SerECmpP
�E SerECmpC
�D SerECmpD
�C 
errn�B�Y
�A 
erob
�@ 
errt
�? 
enum�> �= 0 etext eText  �:�9
�: 
errn�9 0 enumber eNumber �8�7
�8 
erob�7 0 efrom eFrom �6�5�4
�6 
errt�5 
0 eto eTo�4  �< �; 
0 _error  �\ � �b  ��l+ E�O��  *��l+ Y p��  �� *��l+ VY Y��  *�b  ��l+ l+ Y >��  �g *��l+ VY '��  *��l+ Y )��a �a a a a W X  *a ����a + 
� �3	��2�1�0
�3 .Txt:JoiTnull���     ****�2 0 thelist theList�1 �/�.
�/ 
Sepa {�-�,	��- 0 separatortext separatorText�,  �.   �+�*�)�(�'�&�+ 0 thelist theList�* 0 separatortext separatorText�) 0 etext eText�( 0 enumber eNumber�' 0 efrom eFrom�& 
0 eto eTo 	��%�$�#	��"�!�% "0 astextparameter asTextParameter�$ 0 	_jointext 	_joinText�# 0 etext eText � �
�  
errn� 0 enumber eNumber ��
� 
erob� 0 efrom eFrom ���
� 
errt� 
0 eto eTo�  �" �! 
0 _error  �0 ( *�b  ��l+ l+ W X  *墣���+ 
� �
��	
�
� .Txt:SplPnull���     ctxt� 0 thetext theText�  	 ������ 0 thetext theText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo
 
���
"��� "0 astextparameter asTextParameter
� 
cpar� 0 etext eText ��

� 
errn�
 0 enumber eNumber �	�
�	 
erob� 0 efrom eFrom ���
� 
errt� 
0 eto eTo�  � � 
0 _error  � % b  ��l+ �-EW X  *塢���+ 
� �
2���
� .Txt:JoiPnull���     ****� 0 thelist theList� � ��
�  
LiBr {�������� 0 linebreaktype lineBreakType��  
�� LiBrLiOX��   ���������������� 0 thelist theList�� 0 linebreaktype lineBreakType�� 0 separatortext separatorText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo ����������������������
Z����
q����
�� LiBrLiOX
�� 
lnfd
�� LiBrLiCM
�� 
ret 
�� LiBrLiWi
�� 
errn���Y
�� 
erob
�� 
errt
�� 
enum�� �� 0 	_jointext 	_joinText�� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  � Q >��  �E�Y &��  �E�Y ��  
��%E�Y )�������O*��l+ W X  *��a +  ascr  ��ޭ