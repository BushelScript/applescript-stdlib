FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� FormatLib -- parse and format AppleScript values

Notes:

- NSNumberFormatters, NSDateFormatters, etc. (like all other ASOC objects) shouldn't be retained in library (or script objects returned by it) as that breaks store script/save/autosave (caveat: if there is a significant performance difference between creating a formatter once and reusing it vs creating it each time, DateFormatterObjects could be returned as an _alternative_ to using `parse date`/`format date` handlers where user really needs the extra speed; however, documentation would need to state clearly that returned object contains ASOC data so can cause autosave, etc. to fail)


TO DO:

- `format object theData using theTemplate`; theTemplate should be a template string, or a `source code format` (the default) or `human readable format` constant

	- if theTemplate is a constant, theData is formatted as-is (in which case it doesn't have to be a list) using OSADisplay
	
	 - if theTemplate is text, theData should be a list of values to insert into the corresponding placeholders (note: use same $1, $2, etc format as `search text`'s `replacing with TEMPLATE`); need to decide how non-text values are treated

- what about `pad text`? or should that be in TextLib?

- note that `format object` is problematic to implement for some types, as it'll require an AE handler-based implementation to convert some types (e.g. records, references) as ASOC can't convert script objects to NSAppleEventDescriptors, so there's no way to call OSAKit directly (FWIW, writing a script object to temp file via `store script` and reading that into OSALanguage would probably work, but would be slow and humiliatingly hacky); a custom OSAX/event handler wouldn't need to do much: just take a script object (which `format object` would create as a portable wrapper for theData), execute it (the script would just return a value), and get source code (and/or human-readable representation) of the result

- not sure about formatting type class and symbol constants (IIRC, AS only binds application info to reference objects, not type/constant objects, in which case only terms defined in AS's own dictionary will format as keywords and the rest will format using raw chevron syntax unless the appropriate app's terminology is forcibly loaded into AS interpreter at runtime (e.g. using `run script` trickery, or when running scripts in SE)


- `format number`, `parse number` -- canonical/locale-aware options (e.g. decimal, thousands separators), min/max significant places, etc; need to see what Cocoa has available

- note that DateLib and MathLib should also provide their own standard `convert text to TYPE` and `convert TYPE to text` handlers that receive/return a canonical string (e.g. ISO8601, numbers that always use period as decimal separator); unlike using `as` operator to coerce values, this will guarantee reliable conversions from/to text without AS's own current localization settings causing inconsistent/failed results

- what, if any, localization info (via NSLocale) might be relevant/useful to AS users?


- what about NSByteCountFormatter, NSDateComponentsFormatter, NSDateIntervalFormatter, NSEnergyFormatter, NSMassFormatter, NSLengthFormatter, MKDistanceFormatter?

     � 	 	`   F o r m a t L i b   - -   p a r s e   a n d   f o r m a t   A p p l e S c r i p t   v a l u e s 
 
 N o t e s : 
 
 -   N S N u m b e r F o r m a t t e r s ,   N S D a t e F o r m a t t e r s ,   e t c .   ( l i k e   a l l   o t h e r   A S O C   o b j e c t s )   s h o u l d n ' t   b e   r e t a i n e d   i n   l i b r a r y   ( o r   s c r i p t   o b j e c t s   r e t u r n e d   b y   i t )   a s   t h a t   b r e a k s   s t o r e   s c r i p t / s a v e / a u t o s a v e   ( c a v e a t :   i f   t h e r e   i s   a   s i g n i f i c a n t   p e r f o r m a n c e   d i f f e r e n c e   b e t w e e n   c r e a t i n g   a   f o r m a t t e r   o n c e   a n d   r e u s i n g   i t   v s   c r e a t i n g   i t   e a c h   t i m e ,   D a t e F o r m a t t e r O b j e c t s   c o u l d   b e   r e t u r n e d   a s   a n   _ a l t e r n a t i v e _   t o   u s i n g   ` p a r s e   d a t e ` / ` f o r m a t   d a t e `   h a n d l e r s   w h e r e   u s e r   r e a l l y   n e e d s   t h e   e x t r a   s p e e d ;   h o w e v e r ,   d o c u m e n t a t i o n   w o u l d   n e e d   t o   s t a t e   c l e a r l y   t h a t   r e t u r n e d   o b j e c t   c o n t a i n s   A S O C   d a t a   s o   c a n   c a u s e   a u t o s a v e ,   e t c .   t o   f a i l ) 
 
 
 T O   D O : 
 
 -   ` f o r m a t   o b j e c t   t h e D a t a   u s i n g   t h e T e m p l a t e ` ;   t h e T e m p l a t e   s h o u l d   b e   a   t e m p l a t e   s t r i n g ,   o r   a   ` s o u r c e   c o d e   f o r m a t `   ( t h e   d e f a u l t )   o r   ` h u m a n   r e a d a b l e   f o r m a t `   c o n s t a n t 
 
 	 -   i f   t h e T e m p l a t e   i s   a   c o n s t a n t ,   t h e D a t a   i s   f o r m a t t e d   a s - i s   ( i n   w h i c h   c a s e   i t   d o e s n ' t   h a v e   t o   b e   a   l i s t )   u s i n g   O S A D i s p l a y 
 	 
 	   -   i f   t h e T e m p l a t e   i s   t e x t ,   t h e D a t a   s h o u l d   b e   a   l i s t   o f   v a l u e s   t o   i n s e r t   i n t o   t h e   c o r r e s p o n d i n g   p l a c e h o l d e r s   ( n o t e :   u s e   s a m e   $ 1 ,   $ 2 ,   e t c   f o r m a t   a s   ` s e a r c h   t e x t ` ' s   ` r e p l a c i n g   w i t h   T E M P L A T E ` ) ;   n e e d   t o   d e c i d e   h o w   n o n - t e x t   v a l u e s   a r e   t r e a t e d 
 
 -   w h a t   a b o u t   ` p a d   t e x t ` ?   o r   s h o u l d   t h a t   b e   i n   T e x t L i b ? 
 
 -   n o t e   t h a t   ` f o r m a t   o b j e c t `   i s   p r o b l e m a t i c   t o   i m p l e m e n t   f o r   s o m e   t y p e s ,   a s   i t ' l l   r e q u i r e   a n   A E   h a n d l e r - b a s e d   i m p l e m e n t a t i o n   t o   c o n v e r t   s o m e   t y p e s   ( e . g .   r e c o r d s ,   r e f e r e n c e s )   a s   A S O C   c a n ' t   c o n v e r t   s c r i p t   o b j e c t s   t o   N S A p p l e E v e n t D e s c r i p t o r s ,   s o   t h e r e ' s   n o   w a y   t o   c a l l   O S A K i t   d i r e c t l y   ( F W I W ,   w r i t i n g   a   s c r i p t   o b j e c t   t o   t e m p   f i l e   v i a   ` s t o r e   s c r i p t `   a n d   r e a d i n g   t h a t   i n t o   O S A L a n g u a g e   w o u l d   p r o b a b l y   w o r k ,   b u t   w o u l d   b e   s l o w   a n d   h u m i l i a t i n g l y   h a c k y ) ;   a   c u s t o m   O S A X / e v e n t   h a n d l e r   w o u l d n ' t   n e e d   t o   d o   m u c h :   j u s t   t a k e   a   s c r i p t   o b j e c t   ( w h i c h   ` f o r m a t   o b j e c t `   w o u l d   c r e a t e   a s   a   p o r t a b l e   w r a p p e r   f o r   t h e D a t a ) ,   e x e c u t e   i t   ( t h e   s c r i p t   w o u l d   j u s t   r e t u r n   a   v a l u e ) ,   a n d   g e t   s o u r c e   c o d e   ( a n d / o r   h u m a n - r e a d a b l e   r e p r e s e n t a t i o n )   o f   t h e   r e s u l t 
 
 -   n o t   s u r e   a b o u t   f o r m a t t i n g   t y p e   c l a s s   a n d   s y m b o l   c o n s t a n t s   ( I I R C ,   A S   o n l y   b i n d s   a p p l i c a t i o n   i n f o   t o   r e f e r e n c e   o b j e c t s ,   n o t   t y p e / c o n s t a n t   o b j e c t s ,   i n   w h i c h   c a s e   o n l y   t e r m s   d e f i n e d   i n   A S ' s   o w n   d i c t i o n a r y   w i l l   f o r m a t   a s   k e y w o r d s   a n d   t h e   r e s t   w i l l   f o r m a t   u s i n g   r a w   c h e v r o n   s y n t a x   u n l e s s   t h e   a p p r o p r i a t e   a p p ' s   t e r m i n o l o g y   i s   f o r c i b l y   l o a d e d   i n t o   A S   i n t e r p r e t e r   a t   r u n t i m e   ( e . g .   u s i n g   ` r u n   s c r i p t `   t r i c k e r y ,   o r   w h e n   r u n n i n g   s c r i p t s   i n   S E ) 
 
 
 -   ` f o r m a t   n u m b e r ` ,   ` p a r s e   n u m b e r `   - -   c a n o n i c a l / l o c a l e - a w a r e   o p t i o n s   ( e . g .   d e c i m a l ,   t h o u s a n d s   s e p a r a t o r s ) ,   m i n / m a x   s i g n i f i c a n t   p l a c e s ,   e t c ;   n e e d   t o   s e e   w h a t   C o c o a   h a s   a v a i l a b l e 
 
 -   n o t e   t h a t   D a t e L i b   a n d   M a t h L i b   s h o u l d   a l s o   p r o v i d e   t h e i r   o w n   s t a n d a r d   ` c o n v e r t   t e x t   t o   T Y P E `   a n d   ` c o n v e r t   T Y P E   t o   t e x t `   h a n d l e r s   t h a t   r e c e i v e / r e t u r n   a   c a n o n i c a l   s t r i n g   ( e . g .   I S O 8 6 0 1 ,   n u m b e r s   t h a t   a l w a y s   u s e   p e r i o d   a s   d e c i m a l   s e p a r a t o r ) ;   u n l i k e   u s i n g   ` a s `   o p e r a t o r   t o   c o e r c e   v a l u e s ,   t h i s   w i l l   g u a r a n t e e   r e l i a b l e   c o n v e r s i o n s   f r o m / t o   t e x t   w i t h o u t   A S ' s   o w n   c u r r e n t   l o c a l i z a t i o n   s e t t i n g s   c a u s i n g   i n c o n s i s t e n t / f a i l e d   r e s u l t s 
 
 -   w h a t ,   i f   a n y ,   l o c a l i z a t i o n   i n f o   ( v i a   N S L o c a l e )   m i g h t   b e   r e l e v a n t / u s e f u l   t o   A S   u s e r s ? 
 
 
 -   w h a t   a b o u t   N S B y t e C o u n t F o r m a t t e r ,   N S D a t e C o m p o n e n t s F o r m a t t e r ,   N S D a t e I n t e r v a l F o r m a t t e r ,   N S E n e r g y F o r m a t t e r ,   N S M a s s F o r m a t t e r ,   N S L e n g t h F o r m a t t e r ,   M K D i s t a n c e F o r m a t t e r ? 
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      support     �      s u p p o r t      l     ��������  ��  ��       !   l      " # $ " j    �� %�� 0 _supportlib _supportLib % N     & & 4    �� '
�� 
scpt ' m     ( ( � ) ) " L i b r a r y S u p p o r t L i b # "  used for parameter checking    $ � * * 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g !  + , + l     ��������  ��  ��   ,  - . - l     ��������  ��  ��   .  / 0 / i    1 2 1 I      �� 3���� 
0 _error   3  4 5 4 o      ���� 0 handlername handlerName 5  6 7 6 o      ���� 0 etext eText 7  8 9 8 o      ���� 0 enumber eNumber 9  : ; : o      ���� 0 efrom eFrom ;  <�� < o      ���� 
0 eto eTo��  ��   2 n     = > = I    �� ?���� &0 throwcommanderror throwCommandError ?  @ A @ m     B B � C C  F o r m a t L i b A  D E D o    ���� 0 handlername handlerName E  F G F o    ���� 0 etext eText G  H I H o    	���� 0 enumber eNumber I  J K J o   	 
���� 0 efrom eFrom K  L�� L o   
 ���� 
0 eto eTo��  ��   > o     ���� 0 _supportlib _supportLib 0  M N M l     ��������  ��  ��   N  O P O l     ��������  ��  ��   P  Q R Q l     �� S T��   S J D--------------------------------------------------------------------    T � U U � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - R  V W V l     �� X Y��   X   locale support    Y � Z Z    l o c a l e   s u p p o r t W  [ \ [ l     ��������  ��  ��   \  ] ^ ] i    _ ` _ I      �� a����  0 _localeforcode _localeForCode a  b�� b o      ���� 0 
localecode 
localeCode��  ��   ` k     	 c c  d e d l     �� f g��   f ( " TO DO: error if unrecognized code    g � h h D   T O   D O :   e r r o r   i f   u n r e c o g n i z e d   c o d e e  i�� i L     	 j j n     k l k I    �� m���� :0 localewithlocaleidentifier_ localeWithLocaleIdentifier_ m  n�� n o    ���� 0 
localecode 
localeCode��  ��   l n     o p o o    ���� 0 nslocale NSLocale p m     ��
�� misccura��   ^  q r q l     ��������  ��  ��   r  s t s l     �� u v��   u  -----    v � w w 
 - - - - - t  x y x l     ��������  ��  ��   y  z { z i    | } | I     ������
�� .Fmt:LLocnull��� ��� null��  ��   } l     ~  � ~ L      � � c      � � � l     ����� � n     � � � I    �� ����� 60 sortedarrayusingselector_ sortedArrayUsingSelector_ �  ��� � m     � � � � �  c o m p a r e :��  ��   � n     � � � I    �������� 80 availablelocaleidentifiers availableLocaleIdentifiers��  ��   � n     � � � o    ���� 0 nslocale NSLocale � m     ��
�� misccura��  ��   � m    ��
�� 
list  , &> {"af", "af_NA", "af_ZA", "agq", ...}    � � � � L >   { " a f " ,   " a f _ N A " ,   " a f _ Z A " ,   " a g q " ,   . . . } {  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � J D--------------------------------------------------------------------    � � � � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  � � � l     �� � ���   �   numbers    � � � �    n u m b e r s �  � � � l     ��������  ��  ��   �  � � � i   ! � � � I      �� �����  0 _makeformatter _makeFormatter �  � � � o      ���� 0 formatstyle formatStyle �  ��� � o      ���� 0 
localecode 
localeCode��  ��   � k     � � �  � � � r      � � � n     � � � I    �������� 0 init  ��  ��   � n     � � � I    �������� 	0 alloc  ��  ��   � n     � � � o    ���� &0 nsnumberformatter NSNumberFormatter � m     ��
�� misccura � o      ���� 0 theformatter theFormatter �  � � � Z    � � � � � � =    � � � o    ���� 0 formatstyle formatStyle � m    ��
�� FNStFNS0 � n    � � � I    �� ����� "0 setnumberstyle_ setNumberStyle_ �  ��� � l    ����� � n    � � � o    ���� 40 nsnumberformatternostyle NSNumberFormatterNoStyle � m    ��
�� misccura��  ��  ��  ��   � o    ���� 0 theformatter theFormatter �  � � � =   " � � � o     ���� 0 formatstyle formatStyle � m     !��
�� FNStFNS1 �  � � � l  % - � � � � n  % - � � � I   & -�� ����� "0 setnumberstyle_ setNumberStyle_ �  ��� � l  & ) ���~ � n  & ) � � � o   ' )�}�} >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle � m   & '�|
�| misccura�  �~  ��  ��   � o   % &�{�{ 0 theformatter theFormatter � - ' uses thousands separators, no exponent    � � � � N   u s e s   t h o u s a n d s   s e p a r a t o r s ,   n o   e x p o n e n t �  � � � =  0 3 � � � o   0 1�z�z 0 formatstyle formatStyle � m   1 2�y
�y FNStFNS2 �  � � � l  6 > � � � � n  6 > � � � I   7 >�x ��w�x "0 setnumberstyle_ setNumberStyle_ �  ��v � l  7 : ��u�t � n  7 : � � � o   8 :�s�s @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle � m   7 8�r
�r misccura�u  �t  �v  �w   � o   6 7�q�q 0 theformatter theFormatter �   adds currency symbol    � � � � *   a d d s   c u r r e n c y   s y m b o l �  � � � =  A D � � � o   A B�p�p 0 formatstyle formatStyle � m   B C�o
�o FNStFNS3 �  � � � l  G O � � � � n  G O � � � I   H O�n ��m�n "0 setnumberstyle_ setNumberStyle_ �  ��l � l  H K ��k�j � n  H K � � � o   I K�i�i >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle � m   H I�h
�h misccura�k  �j  �l  �m   � o   G H�g�g 0 theformatter theFormatter � ( " multiplies by 100 and appends '%'    � � � � D   m u l t i p l i e s   b y   1 0 0   a n d   a p p e n d s   ' % ' �  � � � =  R U � � � o   R S�f�f 0 formatstyle formatStyle � m   S T�e
�e FNStFNS4 �  � � � n  X ` � � � I   Y `�d ��c�d "0 setnumberstyle_ setNumberStyle_ �  �b  l  Y \�a�` n  Y \ o   Z \�_�_ D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle m   Y Z�^
�^ misccura�a  �`  �b  �c   � o   X Y�]�] 0 theformatter theFormatter �  =  c f o   c d�\�\ 0 formatstyle formatStyle m   d e�[
�[ FNStFNS5 �Z l  i s	
	 n  i s I   j s�Y�X�Y "0 setnumberstyle_ setNumberStyle_ �W l  j o�V�U n  j o o   k o�T�T @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle m   j k�S
�S misccura�V  �U  �W  �X   o   i j�R�R 0 theformatter theFormatter
  	 as words    �    a s   w o r d s�Z   � R   v ��Q
�Q .ascrerr ****      � **** m   � � � b I n v a l i d    i n    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) . �P
�P 
errn m   z }�O�O�Y �N
�N 
erob o   � ��M�M 0 formatstyle formatStyle �L�K
�L 
errt m   � ��J
�J 
enum�K   �  Z   � � �I�H >  � �!"! o   � ��G�G 0 
localecode 
localeCode" m   � ��F
�F 
msng  n  � �#$# I   � ��E%�D�E 0 
setlocale_ 
setLocale_% &�C& I   � ��B'�A�B  0 _localeforcode _localeForCode' (�@( n  � �)*) I   � ��?+�>�? "0 astextparameter asTextParameter+ ,-, o   � ��=�= 0 
localecode 
localeCode- .�<. m   � �// �00  f o r�<  �>  * o   � ��;�; 0 _supportlib _supportLib�@  �A  �C  �D  $ o   � ��:�: 0 theformatter theFormatter�I  �H   1�91 L   � �22 o   � ��8�8 0 theformatter theFormatter�9   � 343 l     �7�6�5�7  �6  �5  4 565 l     �4�3�2�4  �3  �2  6 787 l     �1�0�/�1  �0  �/  8 9:9 l     �.;<�.  ; d ^ TO DO: need `hexadecimal style` option or similar, for converting to/from hex representations   < �== �   T O   D O :   n e e d   ` h e x a d e c i m a l   s t y l e `   o p t i o n   o r   s i m i l a r ,   f o r   c o n v e r t i n g   t o / f r o m   h e x   r e p r e s e n t a t i o n s: >?> l     �-�,�+�-  �,  �+  ? @A@ l     �*BC�*  B � � TO DO: what about specifying decimal places and padding? these are common tasks, so should be optional parameter (e.g. a record containing one or more of: decimal places, minimum decimal places, rounding method, minimum integral places)   C �DD�   T O   D O :   w h a t   a b o u t   s p e c i f y i n g   d e c i m a l   p l a c e s   a n d   p a d d i n g ?   t h e s e   a r e   c o m m o n   t a s k s ,   s o   s h o u l d   b e   o p t i o n a l   p a r a m e t e r   ( e . g .   a   r e c o r d   c o n t a i n i n g   o n e   o r   m o r e   o f :   d e c i m a l   p l a c e s ,   m i n i m u m   d e c i m a l   p l a c e s ,   r o u n d i n g   m e t h o d ,   m i n i m u m   i n t e g r a l   p l a c e s )A EFE l     �)�(�'�)  �(  �'  F GHG i  " %IJI I     �&KL
�& .Fmt:FNumnull���     nmbrK o      �%�% 0 	thenumber 	theNumberL �$MN
�$ 
StylM |�#�"O�!P�#  �"  O o      � �  0 formatstyle formatStyle�!  P l     Q��Q m      �
� FNStFNS0�  �  N �R�
� 
LocaR |��S�T�  �  S o      �� 0 
localecode 
localeCode�  T l     U��U m      �
� 
msng�  �  �  J Q     HVWXV k    6YY Z[Z r    \]\ n   ^_^ I    �`�� &0 asnumberparameter asNumberParameter` aba o    	�� 0 	thenumber 	theNumberb c�c m   	 
dd �ee  �  �  _ o    �� 0 _supportlib _supportLib] o      �� 0 	thenumber 	theNumber[ fgf r    hih I    �j��  0 _makeformatter _makeFormatterj klk o    �� 0 formatstyle formatStylel m�
m o    �	�	 0 
localecode 
localeCode�
  �  i o      �� 0 theformatter theFormatterg non r    #pqp n   !rsr I    !�t�� &0 stringfromnumber_ stringFromNumber_t u�u o    �� 0 	thenumber 	theNumber�  �  s o    �� 0 theformatter theFormatterq o      �� 0 	theresult 	theResulto v�v Z  $ 6wx� ��w =  $ 'yzy o   $ %���� 0 	theresult 	theResultz m   % &��
�� 
msngx R   * 2��{|
�� .ascrerr ****      � ****{ m   0 1}} �~~ . C o u l d n ' t   f o r m a t   n u m b e r .| ���
�� 
errn m   , -�����Y� �����
�� 
erob� o   . /���� 0 	thenumber 	theNumber��  �   ��  �  W R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  X I   > H������� 
0 _error  � ��� m   ? @�� ���  f o r m a t   n u m b e r� ��� o   @ A���� 0 etext eText� ��� o   A B���� 0 enumber eNumber� ��� o   B C���� 0 efrom eFrom� ���� o   C D���� 
0 eto eTo��  ��  H ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  & )��� I     ����
�� .Fmt:PNumnull���     nmbr� o      ���� 0 	thenumber 	theNumber� ����
�� 
Styl� |����������  ��  � o      ���� 0 formatstyle formatStyle��  � l     ������ m      ��
�� FNStFNS0��  ��  � �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      ��
�� 
msng��  ��  ��  � l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �   dates   � ���    d a t e s� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � ; 5 format date theDate using theTemplate for localeCode   � ��� j   f o r m a t   d a t e   t h e D a t e   u s i n g   t h e T e m p l a t e   f o r   l o c a l e C o d e� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��       
�������������  � ����������������
�� 
pimr�� 0 _supportlib _supportLib�� 
0 _error  ��  0 _localeforcode _localeForCode
�� .Fmt:LLocnull��� ��� null��  0 _makeformatter _makeFormatter
�� .Fmt:FNumnull���     nmbr
�� .Fmt:PNumnull���     nmbr� ����� �  �� �����
�� 
cobj� ��   �� 
�� 
frmk��  � ��   �� (
�� 
scpt� �� 2���������� 
0 _error  �� ����� �  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  � ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�  B������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ � �� `����������  0 _localeforcode _localeForCode�� ����� �  ���� 0 
localecode 
localeCode��  � ���� 0 
localecode 
localeCode� ������
�� misccura�� 0 nslocale NSLocale�� :0 localewithlocaleidentifier_ localeWithLocaleIdentifier_�� 
��,�k+ � �� }��������
�� .Fmt:LLocnull��� ��� null��  ��  �  � ����� ��~�}
�� misccura�� 0 nslocale NSLocale� 80 availablelocaleidentifiers availableLocaleIdentifiers�~ 60 sortedarrayusingselector_ sortedArrayUsingSelector_
�} 
list�� ��,j+ �k+ �&� �| ��{�z���y�|  0 _makeformatter _makeFormatter�{ �x��x �  �w�v�w 0 formatstyle formatStyle�v 0 
localecode 
localeCode�z  � �u�t�s�u 0 formatstyle formatStyle�t 0 
localecode 
localeCode�s 0 theformatter theFormatter� �r�q�p�o�n�m�l�k�j�i�h�g�f�e�d�c�b�a�`�_�^�]�\�[/�Z�Y�X
�r misccura�q &0 nsnumberformatter NSNumberFormatter�p 	0 alloc  �o 0 init  
�n FNStFNS0�m 40 nsnumberformatternostyle NSNumberFormatterNoStyle�l "0 setnumberstyle_ setNumberStyle_
�k FNStFNS1�j >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle
�i FNStFNS2�h @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle
�g FNStFNS3�f >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle
�e FNStFNS4�d D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle
�c FNStFNS5�b @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle
�a 
errn�`�Y
�_ 
erob
�^ 
errt
�] 
enum�\ 
�[ 
msng�Z "0 astextparameter asTextParameter�Y  0 _localeforcode _localeForCode�X 0 
setlocale_ 
setLocale_�y ���,j+ j+ E�O��  ���,k+ Y q��  ���,k+ Y `��  ���,k+ Y O��  ���,k+ Y >��  ���,k+ Y -��  ��a ,k+ Y )a a a �a a a a O�a  �*b  �a l+ k+ k+ Y hO�� �WJ�V�U���T
�W .Fmt:FNumnull���     nmbr�V 0 	thenumber 	theNumber�U �S��
�S 
Styl� {�R�Q�P�R 0 formatstyle formatStyle�Q  
�P FNStFNS0� �O��N
�O 
Loca� {�M�L�K�M 0 
localecode 
localeCode�L  
�K 
msng�N  � 	�J�I�H�G�F�E�D�C�B�J 0 	thenumber 	theNumber�I 0 formatstyle formatStyle�H 0 
localecode 
localeCode�G 0 theformatter theFormatter�F 0 	theresult 	theResult�E 0 etext eText�D 0 enumber eNumber�C 0 efrom eFrom�B 
0 eto eTo� d�A�@�?�>�=�<�;�:}�9���8�7�A &0 asnumberparameter asNumberParameter�@  0 _makeformatter _makeFormatter�? &0 stringfromnumber_ stringFromNumber_
�> 
msng
�= 
errn�<�Y
�; 
erob�: �9 0 etext eText� �6�5�
�6 
errn�5 0 enumber eNumber� �4�3�
�4 
erob�3 0 efrom eFrom� �2�1�0
�2 
errt�1 
0 eto eTo�0  �8 �7 
0 _error  �T I 8b  ��l+ E�O*��l+ E�O��k+ E�O��  )�����Y hW X 
 *쥦���+ � �/��.�-���,
�/ .Fmt:PNumnull���     nmbr�. 0 	thenumber 	theNumber�- �+��
�+ 
Styl� {�*�)�(�* 0 formatstyle formatStyle�)  
�( FNStFNS0� �'��&
�' 
Loca� {�%�$�#�% 0 
localecode 
localeCode�$  
�# 
msng�&  � �"�!� �" 0 	thenumber 	theNumber�! 0 formatstyle formatStyle�  0 
localecode 
localeCode�  �, hascr  ��ޭ