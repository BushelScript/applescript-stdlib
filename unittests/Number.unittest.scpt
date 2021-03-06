FasdUAS 1.101.10   ��   ��    k             x     �� ����    4     �� 
�� 
scpt  m     	 	 � 
 
  T e s t T o o l s��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l          x    $�� ����    4     �� 
�� 
scpt  m       �    N u m b e r��      the script being tested     �   0   t h e   s c r i p t   b e i n g   t e s t e d      l     ��������  ��  ��        l     ��������  ��  ��        l     ��������  ��  ��       !   h   $ +�� "�� 20 suite_parseformatnumber suite_ParseFormatNumber " k       # #  $ % $ l     ��������  ��  ��   %  & ' & l     �� ( )��   ( � � `canonical number format` (default) option is designed to mimic AS code's own canonical number formatting, except that NSNumberFormatter doesn't include a "+" symbol before exponent (TO DO: update tests once this inconsistency is fixed)    ) � * *�   ` c a n o n i c a l   n u m b e r   f o r m a t `   ( d e f a u l t )   o p t i o n   i s   d e s i g n e d   t o   m i m i c   A S   c o d e ' s   o w n   c a n o n i c a l   n u m b e r   f o r m a t t i n g ,   e x c e p t   t h a t   N S N u m b e r F o r m a t t e r   d o e s n ' t   i n c l u d e   a   " + "   s y m b o l   b e f o r e   e x p o n e n t   ( T O   D O :   u p d a t e   t e s t s   o n c e   t h i s   i n c o n s i s t e n c y   i s   f i x e d ) '  + , + l     ��������  ��  ��   ,  - . - l     �� / 0��   / � � note that these tests only check that AS wrapper around NSNumberFormatter is working as intended, not that NSNumberFormatter returns results that are appropriate, or even correct    0 � 1 1f   n o t e   t h a t   t h e s e   t e s t s   o n l y   c h e c k   t h a t   A S   w r a p p e r   a r o u n d   N S N u m b e r F o r m a t t e r   i s   w o r k i n g   a s   i n t e n d e d ,   n o t   t h a t   N S N u m b e r F o r m a t t e r   r e t u r n s   r e s u l t s   t h a t   a r e   a p p r o p r i a t e ,   o r   e v e n   c o r r e c t .  2 3 2 l     ��������  ��  ��   3  4 5 4 l     �� 6 7��   65/ TO DO: ideally these tests should be re-run under multiple locales, though [currently?] there's no easy way to do that (while a Cocoa process can easily change its own time zone via `NSTimeZone's setDefaultTimeZone:` while running, there isn't a similar NSLocale method for changing its current locale)    7 � 8 8^   T O   D O :   i d e a l l y   t h e s e   t e s t s   s h o u l d   b e   r e - r u n   u n d e r   m u l t i p l e   l o c a l e s ,   t h o u g h   [ c u r r e n t l y ? ]   t h e r e ' s   n o   e a s y   w a y   t o   d o   t h a t   ( w h i l e   a   C o c o a   p r o c e s s   c a n   e a s i l y   c h a n g e   i t s   o w n   t i m e   z o n e   v i a   ` N S T i m e Z o n e ' s   s e t D e f a u l t T i m e Z o n e : `   w h i l e   r u n n i n g ,   t h e r e   i s n ' t   a   s i m i l a r   N S L o c a l e   m e t h o d   f o r   c h a n g i n g   i t s   c u r r e n t   l o c a l e ) 5  9 : 9 l     ��������  ��  ��   :  ; < ; i     = > = I      �������� 60 test_formatnumber_integer test_formatNumber_integer��  ��   > k     � ? ?  @ A @ I     B�� C B z�� 
�� .���:AsRenull��� ��� null��   C �� D E
�� 
Valu D l  	  F���� F I  	  G H�� G z�� 
�� .Mth:FNumnull���     nmbr H m    ����  ��  ��  ��   E �� I��
�� 
Equa I m     J J � K K  0��   A  L M L I   ; N�� O N z�� 
�� .���:AsRenull��� ��� null��   O �� P Q
�� 
Valu P l  ' 4 R���� R I  ' 4 S T�� S z�� 
�� .Mth:FNumnull���     nmbr T m   . /���� ��  ��  ��   Q �� U��
�� 
Equa U m   5 6 V V � W W  1��   M  X Y X I  < a Z�� [ Z z�� 
�� .���:AsRenull��� ��� null��   [ �� \ ]
�� 
Valu \ l  E R ^���� ^ I  E R _ `�� _ z�� 
�� .Mth:FNumnull���     nmbr ` m   L M���� �����  ��  ��   ] �� a b
�� 
Equa a m   S T c c � d d  - 1 2 3 4 5 6 b �� e��
�� 
Summ e m   W Z f f � g g � f o r   ` c a n o n i c a l   n u m b e r   f o r m a t ` ,   i n t e g e r s   s h o u l d   a p p e a r   e x a c t l y   t h e   s a m e   a s   i n   A S��   Y  h i h I  b � j�� k j z�� 
�� .���:AsRenull��� ��� null��   k �� l m
�� 
Valu l l  m � n���� n I  m � o p�� o z�� 
�� .Mth:FNumnull���     nmbr p l  v � q���� q c   v � r s r \   v } t u t a   v { v w v m   v w����  w m   w z����  u m   { |����  s m   } ���
�� 
long��  ��  ��  ��  ��   m �� x y
�� 
Equa x m   � � z z � { {  5 3 6 8 7 0 9 1 1 y �� |��
�� 
Summ | m   � � } } � ~ ~ p c h e c k   m a x   i n t e g e r   ( A S   i n t s   a r e   3 0   b y t e s ,   i n c l u d i n g   s i g n )��   i  ��  I  � � ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  � � ����� � I  � � � ��� � z�� 
�� .Mth:FNumnull���     nmbr � l  � � ����� � c   � � � � � a   � � � � � m   � ������� � m   � �����  � m   � ���
�� 
long��  ��  ��  ��  ��   � �� � �
�� 
Equa � m   � � � � � � �  - 5 3 6 8 7 0 9 1 2 � �� ���
�� 
Summ � m   � � � � � � � " c h e c k   m i n   i n t e g e r��  ��   <  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� >0 test_formatnumber_realdecimal test_formatNumber_realDecimal��  ��   � k     � �  � � � I     ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  	  ����� � I  	  � ��� � z�� 
�� .Mth:FNumnull���     nmbr � m     � �         ��  ��  ��   � �� ���
�� 
Equa � m     � � � � �  0 . 0��   �  � � � I   ? ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  ' 4 ����� � I  ' 4 � ��� � z�� 
�� .Mth:FNumnull���     nmbr � m   . / � � ?�      ��  ��  ��   � �� � �
�� 
Equa � m   5 6 � � � � �  1 . 0 � �� ��
�� 
Summ � m   7 8 � � � � � � w h e n   f o r m a t t i n g   r e a l s ,   ` c a n o n i c a l   n u m b e r   f o r m a t `   m i m i c s   A S ,   s w i t c h i n g   f r o m   d e c i m a l   t o   s c i e n t i f i c   n o t a t i o n   a u t o m a t i c a l l y�   �  � � � I  @ k ��~ � � z�} 
�} .���:AsRenull��� ��� null�~   � �| � �
�| 
Valu � l  K \ ��{�z � I  K \ � ��y � z�x 
�x .Mth:FNumnull���     nmbr � m   T W � � �(���
=q�y  �{  �z   � �w � �
�w 
Equa � m   ] ` � � � � �  - 1 2 . 3 4 5 � �v ��u
�v 
Summ � m   a d � � � � � � w h e n   f o r m a t t i n g   r e a l s ,   ` c a n o n i c a l   n u m b e r   f o r m a t `   m i m i c s   A S ,   s w i t c h i n g   f r o m   d e c i m a l   t o   s c i e n t i f i c   n o t a t i o n   a u t o m a t i c a l l y�u   �  � � � I  l � ��t � � z�s 
�s .���:AsRenull��� ��� null�t   � �r � �
�r 
Valu � l  w � ��q�p � I  w � � ��o � z�n 
�n .Mth:FNumnull���     nmbr � m   � � � � @$      �o  �q  �p   � �m ��l
�m 
Equa � m   � � � � � � �  1 0 . 0�l   �  � � � I  � � ��k � � z�j 
�j .���:AsRenull��� ��� null�k   � �i � �
�i 
Valu � l  � � ��h�g � I  � � � ��f � z�e 
�e .Mth:FNumnull���     nmbr � m   � � � � @Y      �f  �h  �g   � �d ��c
�d 
Equa � m   � � � � � � � 
 1 0 0 . 0�c   �  � � � I  � � ��b � � z�a 
�a .���:AsRenull��� ��� null�b   � �` � �
�` 
Valu � l  � � ��_�^ � I  � � � ��] � z�\ 
�\ .Mth:FNumnull���     nmbr � m   � � � � @�@     �]  �_  �^   � �[ ��Z
�[ 
Equa � m   � � � � � � �  1 0 0 0 . 0�Z   �  ��Y � I  � ��X � � z�W 
�W .���:AsRenull��� ��� null�X   � �V � �
�V 
Valu � l  � � ��U�T � I  � � � ��S � z�R 
�R .Mth:FNumnull���     nmbr � m   � � � � @^�/��w�S  �U  �T   � �Q ��P
�Q 
Equa � m   � � � � � � �  1 2 3 . 4 5 6�P  �Y   �  � � � l     �O�N�M�O  �N  �M   �  � � � i      I      �L�K�J�L D0  test_formatnumber_realscientific  test_formatNumber_realScientific�K  �J   k     �  I    �I z�H 
�H .���:AsRenull��� ��� null�I   �G
�G 
Valu l  	 	�F�E	 I  	 
�D
 z�C 
�C .Mth:FNumnull���     nmbr m     @È     �D  �F  �E   �B�A
�B 
Equa m     �  1 . 0 E + 4�A    I   ;�@ z�? 
�? .���:AsRenull��� ��� null�@   �>
�> 
Valu l  ' 4�=�< I  ' 4�; z�: 
�: .Mth:FNumnull���     nmbr m   . / A��e    �;  �=  �<   �9�8
�9 
Equa m   5 6 �  1 . 0 E + 9�8    I  < e�7  z�6 
�6 .���:AsRenull��� ��� null�7    �5!"
�5 
Valu! l  E T#�4�3# I  E T$%�2$ z�1 
�1 .Mth:FNumnull���     nmbr% m   L O&& Ag�)�   �2  �4  �3  " �0'(
�0 
Equa' m   U X)) �**  1 . 2 3 4 5 6 7 8 E + 7( �/+�.
�/ 
Summ+ m   [ ^,, �-- � d e f a u l t   f o r m a t   s w i t c h e s   b e t w e e n   d e c i m a l   a n d   s c i e n t i f i c   n o t a t i o n   a u t o m a t i c a l l y�.   ./. I  f �0�-10 z�, 
�, .���:AsRenull��� ��� null�-  1 �+23
�+ 
Valu2 l  q �4�*�)4 I  q �56�(5 z�' 
�' .Mth:FNumnull���     nmbr6 m   z }77 �n���Y�(  �*  �)  3 �&8�%
�& 
Equa8 m   � �99 �::  1 . 0 E - 3 0 0�%  / ;<; I  � �=�$>= z�# 
�# .���:AsRenull��� ��� null�$  > �"?@
�" 
Valu? l  � �A�!� A I  � �BC�B z� 
� .Mth:FNumnull���     nmbrC m   � �DD ��t���\��  �!  �   @ �E�
� 
EquaE m   � �FF �GG  - 1 . 2 3 4 5 E - 3 0 0�  < H�H I  � �I�JI z� 
� .���:AsRenull��� ��� null�  J �KL
� 
ValuK l  � �M��M I  � �NO�N z� 
� .Mth:FNumnull���     nmbrO m   � �PP A�e���  �  �  �  L �Q�
� 
EquaQ m   � �RR �SS  1 . 2 3 4 5 6 7 8 9 E + 9�  �   � TUT l     ����  �  �  U VWV l     ����  �  �  W XYX i   Z[Z I      ��
�	� @0 test_formatnumber_customformat test_formatNumber_customFormat�
  �	  [ k    �\\ ]^] I    _�`_ z� 
� .���:AsRenull��� ��� null�  ` �ab
� 
Valua l  	 c��c I  	 defd z� 
� .Mth:FNumnull���     nmbre m    gg A�e���  f �h�
� 
Usinh m    ii z�  
�  MthZMth2�  �  �  b ��j��
�� 
Equaj l   k����k m    ll �mm  1 , 2 3 4 , 5 6 7 , 8 9 0��  ��  ��  ^ non I    Bp��qp z�� 
�� .���:AsRenull��� ��� null��  q ��rs
�� 
Valur l  ) ;t����t I  ) ;uvwu z�� 
�� .Mth:FNumnull���     nmbrv m   0 1xx A�e���  w ��y��
�� 
Usiny K   2 6zz ��{���� 0 basicformat basicFormat{ m   3 4|| z�� 
�� MthZMth2��  ��  ��  ��  s ��}��
�� 
Equa} l  < =~����~ m   < = ���  1 , 2 3 4 , 5 6 7 , 8 9 0��  ��  ��  o ��� I  C q����� z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  N h������ I  N h���� z�� 
�� .Mth:FNumnull���     nmbr� m   W X�� A�e���  � �����
�� 
Usin� K   Y c�� ������ 0 basicformat basicFormat� m   Z [�� z�� 
�� MthZMth2� ������� &0 groupingseparator groupingSeparator� m   ^ a�� ���  ��  ��  ��  ��  � �����
�� 
Equa� l  i l������ m   i l�� ���  1 2 3 4 5 6 7 8 9 0��  ��  ��  � ��� I  r ������ z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  } ������� I  } ����� z�� 
�� .Mth:FNumnull���     nmbr� m   � ��� A�e���  � �����
�� 
Usin� K   � ��� ������ 0 basicformat basicFormat� m   � ��� z�� 
�� MthZMth2� ������ &0 groupingseparator groupingSeparator� m   � ��� ���  � ������� 40 maximumsignificantdigits maximumSignificantDigits� m   � ����� ��  ��  ��  ��  � �����
�� 
Equa� l  � ������� m   � ��� ���  1 2 3 0 0 0 0 0 0 0��  ��  ��  � ��� I  � ������ z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  � ������� I  � ����� z�� 
�� .Mth:FNumnull���     nmbr� m   � ��� A�e���  � �����
�� 
Usin� K   � ��� ������ 0 basicformat basicFormat� m   � ��� z�� 
�� MthZMth2� ������ &0 groupingseparator groupingSeparator� m   � ��� ���  � ������� ,0 minimumdecimalplaces minimumDecimalPlaces� m   � ����� ��  ��  ��  ��  � �����
�� 
Equa� l  � ������� m   � ��� ���  1 2 3 4 5 6 7 8 9 0 . 0 0 0��  ��  ��  � ��� I  ������ z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  ������� I  ����� z�� 
�� .Mth:FNumnull���     nmbr� m   � ��� A�e���  � �����
�� 
Usin� K   ��� ������ 0 basicformat basicFormat� m   � ��� z�� 
�� MthZMth2� ������ &0 groupingseparator groupingSeparator� m   � ��� ���  � ������ 40 maximumsignificantdigits maximumSignificantDigits� m   � ����� � ������� ,0 minimumdecimalplaces minimumDecimalPlaces� m  ���� ��  ��  ��  ��  � ����
�� 
Equa� l ������ m  �� ���  1 2 3 0 0 0 0 0 0 0��  ��  � �����
�� 
Summ� m  �� ��� � N S N u m b e r F o r m a t t e r   a p p e a r s   t o   o v e r r i d e   m i n i m u m F r a c t i o n D i g i t s   w h e n   s i g n i f i c a n t   d i g i t s   a r e   u s e d��  � ��� I _����� z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l (N������ I (N���� z�� 
�� .Mth:FNumnull���     nmbr� m  14�� @(���$բ� �����
�� 
Usin� K  5I�� ������ 0 basicformat basicFormat� m  67�� z�� 
�� MthZMth2� ������ &0 groupingseparator groupingSeparator� m  :=�� ���  � ������ 40 maximumsignificantdigits maximumSignificantDigits� m  @A���� � ������� ,0 minimumdecimalplaces minimumDecimalPlaces� m  DE���� ��  ��  ��  ��  � �� 
�� 
Equa  l OR���� m  OR �  1 2 . 3��  ��   ����
�� 
Summ m  UX � � N S N u m b e r F o r m a t t e r   a p p e a r s   t o   o v e r r i d e   m i n i m u m F r a c t i o n D i g i t s   w h e n   s i g n i f i c a n t   d i g i t s   a r e   u s e d��  � 	 I `�
��
 z�� 
�� .���:AsRenull��� ��� null��   ��
�� 
Valu l k����� I k� z�� 
�� .Mth:FNumnull���     nmbr m  tw >��#��q ����
�� 
Usin K  x� ���� 0 basicformat basicFormat m  yz z�� 
�� MthZMth2 ������ 40 maximumsignificantdigits maximumSignificantDigits m  }~���� ��  ��  ��  ��   ����
�� 
Equa l ����~ m  �� �  0 . 0 0 0 0 0 1 2 3�  �~  ��  	 �} I ���| z�{ 
�{ .���:AsRenull��� ��� null�|   �z !
�z 
Valu  l ��"�y�x" I ��#$%# z�w 
�w .Mth:FNumnull���     nmbr$ m  ��&& >��#��q% �v'�u
�v 
Usin' K  ��(( �t)*�t 0 basicformat basicFormat) m  ��++ z�s 
�s MthZMth2* �r,-�r 40 maximumsignificantdigits maximumSignificantDigits, m  ���q�q - �p.�o�p $0 roundingbehavior roundingBehavior. m  ��// z�n 
�n MRndRN_F�o  �u  �y  �x  ! �m0�l
�m 
Equa0 l ��1�k�j1 m  ��22 �33  0 . 0 0 0 0 0 1 2 4�k  �j  �l  �}  Y 454 l     �i�h�g�i  �h  �g  5 676 l     �f�e�d�f  �e  �d  7 898 i   :�c: I      �b�a�`�b >0 test_parsenumber_customformat test_parseNumber_customFormat�a  �`  �c  9 ;<; l     �_�^�]�_  �^  �]  < =>= l     �\�[�Z�\  �[  �Z  > ?@? l     �Y�X�W�Y  �X  �W  @ ABA i   CDC I      �V�U�T�V 40 test_formatnumber_locale test_formatNumber_locale�U  �T  D k     �EE FGF I    H�SIH z�R 
�R .���:AsRenull��� ��� null�S  I �QJK
�Q 
ValuJ l  	 L�P�OL I  	 MN�NM z�M 
�M .Mth:FNumnull���     nmbrN m    OO @	�Q��N  �P  �O  K �LPQ
�L 
EquaP m    RR �SS  3 . 1 4Q �KT�J
�K 
SummT m    UU �VV
 u n l i k e   A S ' s   t e x t - n u m b e r   c o e r c i o n s ,   w h i c h   a r e   l o c a l e - d e p e n d e n t ,   b a s i c   f o r m a t t i n g   s h o u l d   i g n o r e   l o c a l e   a n d   a l w a y s   u s e   p e r i o d   s e p a r a t o r s�J  G WXW I    EY�IZY z�H 
�H .���:AsRenull��� ��� null�I  Z �G[\
�G 
Valu[ l  ) 8]�F�E] I  ) 8^_`^ z�D 
�D .Mth:FNumnull���     nmbr_ m   0 1aa @	�Q�` �Cb�B
�C 
Locab m   2 3cc �dd 
 d e _ D E�B  �F  �E  \ �Aef
�A 
Equae m   9 <gg �hh  3 , 1 4f �@i�?
�@ 
Summi m   = @jj �kk n G e r m a n y   u s e s   c o m m a s ,   n o t   p e r i o d s ,   a s   d e c i m a l   s e p a r a t o r s�?  X lml I  F wn�>on z�= 
�= .���:AsRenull��� ��� null�>  o �<pq
�< 
Valup l  Q lr�;�:r I  Q lstus z�9 
�9 .Mth:FNumnull���     nmbrt m   Z [vv @	�Q�u �8wx
�8 
Usinw m   ^ ayy z�7 
�7 MthZMth5x �6z�5
�6 
Locaz m   b e{{ �|| 
 e n _ U S�5  �;  �:  q �4}�3
�4 
Equa} m   m p~~ � 
 $ 3 . 1 4�3  m ��2� I  x ���1�� z�0 
�0 .���:AsRenull��� ��� null�1  � �/��
�/ 
Valu� l  � ���.�-� I  � ����� z�, 
�, .Mth:FNumnull���     nmbr� m   � ��� @���1��� �+��
�+ 
Usin� m   � ��� z�* 
�* MthZMth5� �)��(
�) 
Loca� m   � ��� ��� 
 d e _ D E�(  �.  �-  � �'��&
�' 
Equa� m   � ��� ���  1 2 . 3 4 5 , 6 8 � ��&  �2  B ��� l     �%�$�#�%  �$  �#  � ��� l     �"�!� �"  �!  �   � ��� i   ��� I      ���� 20 test_parsenumber_locale test_parseNumber_locale�  �  � k     ?�� ��� I    ���� z� 
� .���:AsRenull��� ��� null�  � ���
� 
Valu� l  	 ���� I  	 ���� z� 
� .Mth:PNumnull���     ctxt� m    �� ���  3 . 1 4�  �  �  � ���
� 
Equa� m    �� @	�Q��  � ��� I   =���� z� 
� .���:AsRenull��� ��� null�  � ���
� 
Valu� l  ' 6���� I  ' 6���� z� 
� .Mth:PNumnull���     ctxt� m   . /�� ���  3 , 1 4� ���
� 
Loca� m   0 1�� ��� 
 d e _ D E�  �  �  � ���

� 
Equa� m   7 8�� @	�Q��
  � ��	� l  > >����  �  �  �	  � ��� l     ����  �  �  � ��� l     �� ���  �   ��  �   ! ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �   TO DO: parse/format hex   � ��� 0   T O   D O :   p a r s e / f o r m a t   h e x� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� h   , 3����� 20 suite_generaloperations suite_GeneralOperations� k      �� ��� l     ��������  ��  ��  � ��� l     ������  � Q K TO DO: cmp (make sure to check with very large and very small numbers too)   � ��� �   T O   D O :   c m p   ( m a k e   s u r e   t o   c h e c k   w i t h   v e r y   l a r g e   a n d   v e r y   s m a l l   n u m b e r s   t o o )� ��� l     ��������  ��  ��  � ��� i    ��� I      �������� $0 test_roundnumber test_roundNumber��  ��  � k    ��� ��� I    /����� z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  	 ������ I  	 ���� z�� 
�� .Mth:RouNnull���     nmbr� m    �� @�z�G�� �����
�� 
Plac� m    ���� ��  ��  ��  � ����
�� 
Equa� m    �� @�\(�� ����
�� 
Usin� l   (������ I   (������ z�� 
�� .���:NmEqnull��� ��� null��  ��  ��  ��  � �����
�� 
Summ� m   ) *�� ��� D d e f a u l t   i s   t o   r o u n d   h a l v e s   t o   e v e n��  � ��� I  0 i����� z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  ; N������ I  ; N���� z�� 
�� .Mth:RouNnull���     nmbr� m   D G�� @�z��z�� �� ��
�� 
Plac  m   H I���� ��  ��  ��  � ��
�� 
Equa m   O R @������ ����
�� 
Usin l  S b���� I  S b���� z�� 
�� .���:NmEqnull��� ��� null��  ��  ��  ��  ��  �  I  j �	��
	 z�� 
�� .���:AsRenull��� ��� null��  
 ��
�� 
Valu l  u ����� I  u � z�� 
�� .Mth:RouNnull���     nmbr m   ~ � @�z��� ����
�� 
Plac m   � ����� ��  ��  ��   ��
�� 
Equa m   � � @�\(� ����
�� 
Usin l  � ����� I  � ����� z�� 
�� .���:NmEqnull��� ��� null��  ��  ��  ��  ��    I  � ��� z�� 
�� .���:AsRenull��� ��� null��   ��
�� 
Valu l  � ����� I  � � !"  z�� 
�� .Mth:RouNnull���     nmbr! m   � �## @�=p��
" ��$��
�� 
Plac$ m   � ����� ��  ��  ��   ��%&
�� 
Equa% m   � �'' @�\(�& ��()
�� 
Usin( l  � �*����* I  � �+����+ z�� 
�� .���:NmEqnull��� ��� null��  ��  ��  ��  ) ��,��
�� 
Summ, m   � �-- �..  ` r o u n d   n u m b e r `   s h o u l d   a l l o w   f o r   m i n o r   i m p r e c i s i o n s   i n   F P ,   s o   w h i l e   ' 4 . 1 3 5 '   i s   r e a l l y   4 . 1 3 4 9 9 9 9 &   i t   s h o u l d   s t i l l   r o u n d   u p   t o   4 . 1 4��   /0/ I  �1��21 z�� 
�� .���:AsRenull��� ��� null��  2 ��34
�� 
Valu3 l  � �5����5 I  � �6786 z�� 
�� .Mth:RouNnull���     nmbr7 m   � �99 @�=qO��8 ��:��
�� 
Plac: m   � ����� ��  ��  ��  4 ��;<
�� 
Equa; m   � �== @�\(�< ��>��
�� 
Usin> l  �?����? I  �@����@ z�� 
�� .���:NmEqnull��� ��� null��  ��  ��  ��  ��  0 ABA I MC��DC z�� 
�� .���:AsRenull��� ��� null��  D ��EF
�� 
ValuE l 2G����G I 2HIJH z�� 
�� .Mth:RouNnull���     nmbrI m  (+KK @�=o�
�J ��L��
�� 
PlacL m  ,-���� ��  ��  ��  F ��MN
�� 
EquaM m  36OO @��Q�N ��P��
�� 
UsinP l 7FQ���Q I 7FR�~�}R z�| 
�| .���:NmEqnull��� ��� null�~  �}  ��  �  ��  B STS I N�U�{VU z�z 
�z .���:AsRenull��� ��� null�{  V �yWX
�y 
ValuW l YtY�x�wY I YtZ[\Z z�v 
�v .Mth:RouNnull���     nmbr[ m  be]] �!�Q�\ �u^_
�u 
Plac^ m  fg�t�t _ �s`�r
�s 
Dire` m  jmaa z�q 
�q MRndRN_F�r  �x  �w  X �pbc
�p 
Equab m  uxdd �!333333c �oe�n
�o 
Usine l y�f�m�lf I y�g�k�jg z�i 
�i .���:NmEqnull��� ��� null�k  �j  �m  �l  �n  T hih I ��j�hkj z�g 
�g .���:AsRenull��� ��� null�h  k �flm
�f 
Valul l ��n�e�dn I ��opqo z�c 
�c .Mth:RouNnull���     nmbrp m  ��rr @�     q �bs�a
�b 
Placs m  ��tt �       �a  �e  �d  m �`uv
�` 
Equau m  ���_�_�v �^w�]
�^ 
Usinw l ��x�\�[x I ��y�Z�Yy z�X 
�X .���:NmEqnull��� ��� null�Z  �Y  �\  �[  �]  i z{z l ���W|}�W  | � � TO DO: need to test all rounding options (in particular, make sure all the extra 100 multipliers+divisors to deal with rounding imprecision are applied correctly)   } �~~F   T O   D O :   n e e d   t o   t e s t   a l l   r o u n d i n g   o p t i o n s   ( i n   p a r t i c u l a r ,   m a k e   s u r e   a l l   t h e   e x t r a   1 0 0   m u l t i p l i e r s + d i v i s o r s   t o   d e a l   w i t h   r o u n d i n g   i m p r e c i s i o n   a r e   a p p l i e d   c o r r e c t l y ){ �V I ����U�� z�T 
�T .���:AsErnull��� ��� null�U  � �S��
�S 
Equa� K  ���� �R���R 0 errornumber errorNumber� m  ���Q�Q�Y� �P��O�P 0 	fromvalue 	fromValue� m  ���� @      �O  � �N��M
�N 
Summ� m  ���� ��� @ ` t o   p l a c e s `   m u s t   b e   w h o l e   n u m b e r�M  �V  � ��� l     �L�K�J�L  �K  �J  � ��� i   ��� I      �I�H�G�I $0 call_roundnumber call_roundNumber�H  �G  � I    ���� z�F 
�F .Mth:RouNnull���     nmbr� m    �� @�z�G�� �E��D
�E 
Plac� m   	 
�� @      �D  � ��� l     �C�B�A�C  �B  �A  � ��� i   ��� I      �@�?�>�@ 0 test_min_max  �?  �>  � k    �� ��� I    %��=�� z�< 
�< .���:AsRenull��� ��� null�=  � �;��
�; 
Valu� l  	 ��:�9� I  	 ���8� z�7 
�7 .Mth:MinNnull���     ****� J    �� ��� m    �6�6 � ��� m    �5�5 � ��� m    �4�4 � ��� m    �3�3 � ��� m    �2�2 � ��� m    �1�1 � ��0� m    �/�/ �0  �8  �:  �9  � �.��-
�. 
Equa� l    ��,�+� m     �*�* �,  �+  �-  � ��� I  & J��)�� z�( 
�( .���:AsErnull��� ��� null�)  � �'��
�' 
Hand� m   / 0�� ���  c a l l _ m i n� �&��
�& 
Args� J   1 3�%�%  � �$��#
�$ 
Equa� K   4 E�� �"���" 0 errornumber errorNumber� m   5 8�!�!�Y� � ���  0 errormessage errorMessage� m   ; >�� ��� � N u m b e r   l i b r a r y   c a n  t   m i n :   I n v a l i d   d i r e c t   p a r a m e t e r :   L i s t   c a n  t   b e   e m p t y .� ���� 0 	fromvalue 	fromValue� J   A C��  �  �#  � ��� I  K ����� z� 
� .���:AsErnull��� ��� null�  � ���
� 
Hand� m   V Y�� ���  c a l l _ m i n� ���
� 
Args� J   Z `�� ��� m   Z [�� � ��� m   [ ^�
� 
msng�  � ���
� 
Equa� K   a ��� ���� 0 errornumber errorNumber� m   b e���Y� ���� 0 errormessage errorMessage� m   h k�� ��� � N u m b e r   l i b r a r y   c a n  t   m i n :   I n v a l i d   d i r e c t   p a r a m e t e r :   L i s t   i t e m   i s   w r o n g   t y p e :   C a n  t   m a k e   m i s s i n g   v a l u e   i n t o   t y p e   n u m b e r .� ���� 0 	fromvalue 	fromValue� N   n z�� n   n y��� 4   t y��
� 
cobj� m   w x�� � J   n t�� ��� m   n o�� � ��� m   o r�
� 
msng�  � �
��	�
 0 totype toType� m   } ��
� 
nmbr�	  �  � ��� I  � ����� z� 
� .���:AsRenull��� ��� null�  � ���
� 
Valu� l  � ����� I  � ����� z� 
� .Mth:MaxNnull���     ****� J   � ��� ��� m   � �� �  � ��� m   � ����� � ��� m   � ����� � ��� m   � ����� � ��� m   � ����� �    m   � �����  �� m   � ����� ��  �  �  �  � ����
�� 
Equa l  � ����� m   � ����� ��  ��  ��  �  I  � ��� z�� 
�� .���:AsErnull��� ��� null��   ��	

�� 
Hand	 m   � � �  c a l l _ m a x
 ��
�� 
Args J   � �����   ����
�� 
Equa K   � � ���� 0 errornumber errorNumber m   � ������Y ���� 0 errormessage errorMessage m   � � � � N u m b e r   l i b r a r y   c a n  t   m a x :   I n v a l i d   d i r e c t   p a r a m e t e r :   L i s t   c a n  t   b e   e m p t y . ������ 0 	fromvalue 	fromValue J   � �����  ��  ��   �� I  ��� z�� 
�� .���:AsErnull��� ��� null��   ��
�� 
Hand m   � � �  c a l l _ m a x �� 
�� 
Args J   � �!! "#" m   � ����� # $��$ m   � ���
�� 
msng��    ��%��
�� 
Equa% K   �&& ��'(�� 0 errornumber errorNumber' m   � ������Y( ��)*�� 0 errormessage errorMessage) m   � �++ �,, � N u m b e r   l i b r a r y   c a n  t   m a x :   I n v a l i d   d i r e c t   p a r a m e t e r :   L i s t   i t e m   i s   w r o n g   t y p e :   C a n  t   m a k e   m i s s i n g   v a l u e   i n t o   t y p e   n u m b e r .* ��-.�� 0 	fromvalue 	fromValue- N   �
// n   �	010 4  	��2
�� 
cobj2 m  ���� 1 J   �33 454 m   � ����� 5 6��6 m   ���
�� 
msng��  . ��7���� 0 totype toType7 m  ��
�� 
nmbr��  ��  ��  � 898 l     ��������  ��  ��  9 :;: i   <=< I      ��>���� 0 call_min  > ?��? o      ���� 0 alist aList��  ��  = I    @A��@ z�� 
�� .Mth:MinNnull���     ****A o    ���� 0 alist aList��  ; BCB l     ��������  ��  ��  C DED i   FGF I      ��H���� 0 call_max  H I��I o      ���� 0 alist aList��  ��  G I    JK��J z�� 
�� .Mth:MaxNnull���     ****K o    ���� 0 alist aList��  E L��L l     ��������  ��  ��  ��  � MNM l     ��������  ��  ��  N OPO l     ��������  ��  ��  P QRQ l     ��������  ��  ��  R STS l     ��������  ��  ��  T UVU i   4 7WXW I     ������
�� .aevtoappnull  �   � ****��  ��  X l    YZ[Y I    \]��\ z�� 
�� .���:RunTnull���     file] l   ^����^ I   ��_��
�� .earsffdralis        afdr_  f    ��  ��  ��  ��  Z N H including this command allows tests to be run directly in Script Editor   [ �`` �   i n c l u d i n g   t h i s   c o m m a n d   a l l o w s   t e s t s   t o   b e   r u n   d i r e c t l y   i n   S c r i p t   E d i t o rV aba l     ��������  ��  ��  b cdc l     ��������  ��  ��  d e��e l     ��������  ��  ��  ��       ��fghij��  f ��������
�� 
pimr�� 20 suite_parseformatnumber suite_ParseFormatNumber�� 20 suite_generaloperations suite_GeneralOperations
�� .aevtoappnull  �   � ****g ��k�� k  lmnl ��o��
�� 
cobjo pp   �� 	
�� 
scpt��  m ��q��
�� 
cobjq rr   ��
�� 
osax��  n ��s��
�� 
cobjs tt   �� 
�� 
scpt��  h �� "  u�� 20 suite_parseformatnumber suite_ParseFormatNumberu 	��vwxyz{|}��  v ���������������� 60 test_formatnumber_integer test_formatNumber_integer�� >0 test_formatnumber_realdecimal test_formatNumber_realDecimal�� D0  test_formatnumber_realscientific  test_formatNumber_realScientific�� @0 test_formatnumber_customformat test_formatNumber_customFormat�� >0 test_parsenumber_customformat test_parseNumber_customFormat�� 40 test_formatnumber_locale test_formatNumber_locale�� 20 test_parsenumber_locale test_parseNumber_localew �� >���~�~�� 60 test_formatnumber_integer test_formatNumber_integer��  �  ~   �} 	�| �{�z J�y�x 	  V 	 �w c�v f�u 	 �t�s z } 	 �r � �
�} 
scpt
�| 
Valu
�{ .Mth:FNumnull���     nmbr
�z 
Equa�y 
�x .���:AsRenull��� ��� null�w ���
�v 
Summ�u �t 
�s 
long�r���~ �)��/ *�)��/ jj U��� UO)��/ *�)��/ kj U��� UO)��/ *�)��/ �j U��a a a  UO)�a / -*�)�a / la $ka &j U�a a a a  UO)�a / -*�)�a / a a $a &j U�a a a a  Ux �q ��p�o���n�q >0 test_formatnumber_realdecimal test_formatNumber_realDecimal�p  �o  �  � &�m 	�l  ��k�j ��i�h 	  � ��g ��f 	  � � � 	  � � 	  � � 	  � � 	  � �
�m 
scpt
�l 
Valu
�k .Mth:FNumnull���     nmbr
�j 
Equa�i 
�h .���:AsRenull��� ��� null
�g 
Summ�f �n)��/ *�)��/ �j U��� 	UO)��/ *�)��/ �j U����a  	UO)�a / #*�)�a / 	a j U�a �a a  	UO)�a / *�)�a / 	a j U�a � 	UO)�a / *�)�a / 	a j U�a � 	UO)�a / *�)�a / 	a  j U�a !� 	UO)�a "/ *�)�a #/ 	a $j U�a %� 	Uy �e�d�c���b�e D0  test_formatnumber_realscientific  test_formatNumber_realScientific�d  �c  �  � !�a 	�` �_�^�]�\ 	  	 &)�[,�Z 	 79 	 DF 	 PR
�a 
scpt
�` 
Valu
�_ .Mth:FNumnull���     nmbr
�^ 
Equa�] 
�\ .���:AsRenull��� ��� null
�[ 
Summ�Z �b �)��/ *�)��/ �j U��� 	UO)��/ *�)��/ �j U��� 	UO)��/ #*�)��/ 	a j U�a a a a  	UO)�a / *�)�a / 	a j U�a � 	UO)�a / *�)�a / 	a j U�a � 	UO)�a / *�)�a / 	a j U�a  � 	Uz �Y[�X�W���V�Y @0 test_formatnumber_customformat test_formatNumber_customFormat�X  �W  �  � 6�U 	�T g�S�R�Q�Pl�O�N 	 �M 	 �L�� 	 ��K�J� 	 ��I� 	 ��H��G� 	 �� 	  	 �F�E2
�U 
scpt
�T 
Valu
�S 
Usin
�R MthZMth2
�Q .Mth:FNumnull���     nmbr
�P 
Equa�O 
�N .���:AsRenull��� ��� null�M 0 basicformat basicFormat�L &0 groupingseparator groupingSeparator�K 40 maximumsignificantdigits maximumSignificantDigits�J �I ,0 minimumdecimalplaces minimumDecimalPlaces�H 
�G 
Summ�F $0 roundingbehavior roundingBehavior
�E MRndRN_F�V�)��/ *�)��/ 	���l U��� UO)��/ *�)��/ ����ll U��� UO)�a / &*�)�a / ����a a �l U�a � UO)�a / ,*�)�a / ����a a a ma l U�a � UO)�a / ,*�)�a / ����a a a ma l U�a � UO)�a  / 8*�)�a !/ ����a a "a ma ma #l U�a $a %a &a  UO)�a '/ :*�)�a (/ a )���a a *a ma ma #l U�a +a %a ,a  UO)�a -/ &*�)�a ./ a /���a m�l U�a 0� UO)�a 1/ .*�)�a 2/ a /���a ma 3a 4a l U�a 5� U{ �D�C�B�A���@�D >0 test_parsenumber_customformat test_parseNumber_customFormat�C  �B  �A  �  �  �@ h| �?D�>�=���<�? 40 test_formatnumber_locale test_formatNumber_locale�>  �=  �  � �; 	�: O�9�8R�7U�6�5 	 �4cgj 	 �3�2{�1~ 	 ���
�; 
scpt
�: 
Valu
�9 .Mth:FNumnull���     nmbr
�8 
Equa
�7 
Summ�6 
�5 .���:AsRenull��� ��� null
�4 
Loca
�3 
Usin
�2 MthZMth5�1 �< �)��/ *�)��/ �j U����� UO)��/ *�)��/ 	���l U�a �a � UO)�a / )*�)�a / �a a �a a  U�a a  UO)�a / +*�)�a / a a a �a a  U�a a  U} �0��/�.���-�0 20 test_parsenumber_locale test_parseNumber_locale�/  �.  �  � �, 	�+ ��*�)��(�' 	 ��&�
�, 
scpt
�+ 
Valu
�* .Mth:PNumnull���     ctxt
�) 
Equa�( 
�' .���:AsRenull��� ��� null
�& 
Loca�- @)��/ *�)��/ �j U��� 	UO)��/ *�)��/ 	���l U��� 	UOPi �%�  ��% 20 suite_generaloperations suite_GeneralOperations� �$�������$  � �#�"�!� ��# $0 test_roundnumber test_roundNumber�" $0 call_roundnumber call_roundNumber�! 0 test_min_max  �  0 call_min  � 0 call_max  � �������� $0 test_roundnumber test_roundNumber�  �  �  � =� 	� ������ 	����� 	 � 	� 	  	 	 # 	- 	 9 	 	 KO 	 	 ]���d 	 	 rt� 	 	��
�	���
� 
scpt
� 
Valu
� 
Plac
� .Mth:RouNnull���     nmbr
� 
Equa
� 
Usin
� .���:NmEqnull��� ��� null
� 
Summ� 
� .���:AsRenull��� ��� null� 
� 
Dire
� MRndRN_F� ��� 0 errornumber errorNumber�
�Y�	 0 	fromvalue 	fromValue
� .���:AsErnull��� ��� null��)��/ )*�)��/ 	��ll U���)��/ *j U��� UO)�a / 1*�)�a / a �ll U�a �)�a / *j Ua  UO)�a / /*�)�a / a �ll U���)�a / *j Ua  UO)�a / 1*�)�a / a �ll U���)�a / *j U�a � UO)�a / /*�)�a  / a !�ll U���)�a "/ *j Ua  UO)�a #/ 1*�)�a $/ a %�ll U�a &�)�a '/ *j Ua  UO)�a (/ 9*�)�a )/ a *�ka +a ,a - U�a .�)�a // *j Ua  UO)�a 0/ 3*�)�a 1/ a 2�a 3l U�a 4�)�a 5/ *j Ua  UO)�a 6/ *�a 7a 8a 9a :a -�a ;a - <U� �������� $0 call_roundnumber call_roundNumber�  �  �  � � ����
� 
scpt
� 
Plac
� .Mth:RouNnull���     nmbr� )��/ 	���l U� � ����������  0 test_min_max  ��  ��  �  � %�� 	�� �������������� 	���������������� 	���������� 	 �� 	 	+
�� 
scpt
�� 
Valu�� �� �� 
�� .Mth:MinNnull���     ****
�� 
Equa�� 
�� .���:AsRenull��� ��� null
�� 
Hand
�� 
Args�� 0 errornumber errorNumber���Y�� 0 errormessage errorMessage�� 0 	fromvalue 	fromValue
�� .���:AsErnull��� ��� null
�� 
msng
�� 
cobj�� 0 totype toType
�� 
nmbr
�� .Mth:MaxNnull���     ****��)��/ *�)��/ k�mk����vj U�k� 
UO)��/ *���jv��a a a a jv�� UO)�a / 4*�a �ka lv��a a a a ka lva l/a a �� UO)�a / !*�)�a / k�mk����vj U��� 
UO)�a /  *�a  �jv��a a a !a jv�� UO)�a "/ 4*�a #�ka lv��a a a $a ka lva l/a a �� U� ��=���������� 0 call_min  �� ����� �  ���� 0 alist aList��  � ���� 0 alist aList� �� ��
�� 
scpt
�� .Mth:MinNnull���     ****�� )��/ �j U� ��G���������� 0 call_max  �� ����� �  ���� 0 alist aList��  � ���� 0 alist aList� �� ��
�� 
scpt
�� .Mth:MaxNnull���     ****�� )��/ �j Uj ��X��������
�� .aevtoappnull  �   � ****��  ��  �  � �� 	����
�� 
scpt
�� .earsffdralis        afdr
�� .���:RunTnull���     file�� )��/ )j j U ascr  ��ޭ