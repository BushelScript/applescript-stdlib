FasdUAS 1.101.10   ��   ��    k             x     �� ����    4     �� 
�� 
scpt  m     	 	 � 
 
  T e s t T o o l s��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l          x    $�� ����    4     �� 
�� 
scpt  m       �    F i l e��      the script being tested     �   0   t h e   s c r i p t   b e i n g   t e s t e d      l     ��������  ��  ��        l     ��������  ��  ��        h   $ +��  �� 00 suite_pathmanipulation suite_PathManipulation   k       ! !  " # " x     �� $����   $ 4    �� %
�� 
frmk % m     & & � ' '  F o u n d a t i o n��   #  ( ) ( l     ��������  ��  ��   )  * + * j    �� ,�� 0 	_username 	_userName , m    ��
�� 
msng +  - . - j    �� /�� 0 	_userhome 	_userHome / m    ��
�� 
msng .  0 1 0 l     ��������  ��  ��   1  2 3 2 i    4 5 4 I      �������� "0 configure_setup configure_setUp��  ��   5 k     / 6 6  7 8 7 O      9 : 9 k     ; ;  < = < r     > ? > n    	 @ A @ 1    	��
�� 
pnam A 1    ��
�� 
home ? o      ���� 0 	_username 	_userName =  B�� B r     C D C n     E F E 1    ��
�� 
psxp F l    G���� G c     H I H 1    ��
�� 
home I m    ��
�� 
alis��  ��   D o      ���� 0 	_userhome 	_userHome��   : m      J J�                                                                                  MACS  alis    t  Macintosh HD               �n+�H+  K��
Finder.app                                                     N7����        ����  	                CoreServices    �n�      ���    K��K��K��  6Macintosh HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��   8  K�� K l   / L M N L n   / O P O I   & /�� Q���� :0 changecurrentdirectorypath_ changeCurrentDirectoryPath_ Q  R�� R o   & +���� 0 	_userhome 	_userHome��  ��   P n   & S T S I   " &��������  0 defaultmanager defaultManager��  ��   T n   " U V U o     "���� 0 nsfilemanager NSFileManager V m     ��
�� misccura M � } make sure CWD is always ~/ so that `normalize path` and `join path` always return known result when expanding relative paths    N � W W �   m a k e   s u r e   C W D   i s   a l w a y s   ~ /   s o   t h a t   ` n o r m a l i z e   p a t h `   a n d   ` j o i n   p a t h `   a l w a y s   r e t u r n   k n o w n   r e s u l t   w h e n   e x p a n d i n g   r e l a t i v e   p a t h s��   3  X Y X l     ��������  ��  ��   Y  Z [ Z i    \ ] \ I      �������� $0 test_convertpath test_convertPath��  ��   ] k     � ^ ^  _ ` _ I     a�� b a z�� 
�� .���:AsRenull��� ��� null��   b �� c d
�� 
Valu c l  	  e���� e I  	  f g h f z�� 
�� .Fil:ConPnull���     **** g m     i i � j j 8 / U s e r s / j s m i t h / U s e r   G u i d e . t x t h �� k��
�� 
To__ k m     l l z�� 
�� FLCTFLCH��  ��  ��   d �� m��
�� 
Equa m l    n���� n m     o o � p p P M a c i n t o s h   H D : U s e r s : j s m i t h : U s e r   G u i d e . t x t��  ��  ��   `  q r q I    A s�� t s z�� 
�� .���:AsRenull��� ��� null��   t �� u v
�� 
Valu u l  ) 8 w���� w I  ) 8 x y z x z�� 
�� .Fil:ConPnull���     **** y m   0 1 { { � | | P M a c i n t o s h   H D : U s e r s : j s m i t h : U s e r   G u i d e . t x t z �� }��
�� 
From } m   2 3 ~ ~ z�� 
�� FLCTFLCH��  ��  ��   v �� ��
�� 
Equa  l  9 < ����� � m   9 < � � � � � 8 / U s e r s / j s m i t h / U s e r   G u i d e . t x t��  ��  ��   r  � � � I  B p ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  M b ����� � I  M b � � � � z�� 
�� .Fil:ConPnull���     **** � m   V Y � � � � � 8 / U s e r s / j s m i t h / U s e r   G u i d e . t x t � �� ���
�� 
To__ � m   Z ] � � z�� 
�� FLCTFLCX��  ��  ��   � �� ���
�� 
Equa � l  c k ����� � 4   c k�� �
�� 
psxf � m   g j � � � � � 8 / U s e r s / j s m i t h / U s e r   G u i d e . t x t��  ��  ��   �  ��� � I  q � ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  | � ����� � I  | � � � � � z�� 
�� .Fil:ConPnull���     **** � l  � � ����� � 4   � ��� �
�� 
psxf � m   � � � � � � � 8 / U s e r s / j s m i t h / U s e r   G u i d e . t x t��  ��   � �� ���
�� 
To__ � m   � � � � z�� 
�� FLCTFLCU��  ��  ��   � �� ���
�� 
Equa � l  � � ����� � m   � � � � � � � J f i l e : / / / U s e r s / j s m i t h / U s e r % 2 0 G u i d e . t x t��  ��  ��  ��   [  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� (0 test_normalizepath test_normalizePath��  ��   � k     � � �  � � � I    ' ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  	  ���~ � I  	  � � � � z�} 
�} .Fil:NorPnull���     ctxt � m     � � � � � N ~ / P i c t u r e s / / C a m e r a   R o l l / . . / . / . . / M o v i e s / � �| ��{
�| 
ExpT � m    �z
�z boovtrue�{  �  �~   � �y ��x
�y 
Equa � l   " ��w�v � b    " � � � b      � � � m     � � � � �  / U s e r s / � o    �u�u 0 	_username 	_userName � m     ! � � � � �  / M o v i e s�w  �v  �x   �  � � � I  ( S ��t � � z�s 
�s .���:AsRenull��� ��� null�t   � �r � �
�r 
Valu � l  1 @ ��q�p � I  1 @ � � � � z�o 
�o .Fil:NorPnull���     ctxt � m   8 9 � � � � �  . / M u s i c / i T u n e s � �n ��m
�n 
ExpR � m   : ;�l
�l boovtrue�m  �q  �p   � �k ��j
�k 
Equa � l  A N ��i�h � b   A N � � � b   A J � � � m   A D � � � � �  / U s e r s / � o   D I�g�g 0 	_username 	_userName � m   J M � � � � �  / M u s i c / i T u n e s�i  �h  �j   �  � � � I  T � ��f � � z�e 
�e .���:AsRenull��� ��� null�f   � �d � �
�d 
Valu � l  _ p ��c�b � I  _ p � ��a � z�` 
�` .Fil:NorPnull���     ctxt � m   h k � � � � � N ~ / P i c t u r e s / / C a m e r a   R o l l / . . / . / . . / M o v i e s /�a  �c  �b   � �_ � �
�_ 
Equa � l  q t ��^�] � m   q t � � � � � F ~ / P i c t u r e s / C a m e r a   R o l l / . . / . . / M o v i e s�^  �]   � �\ ��[
�\ 
Summ � m   w z � � � � � P  . .    i s   o n l y   e x p a n d e d   f o r   a b s o l u t e   p a t h s�[   �  ��Z � I  � � ��Y � � z�X 
�X .���:AsRenull��� ��� null�Y   � �W � �
�W 
Valu � l  � � ��V�U � I  � � � ��T � z�S 
�S .Fil:NorPnull���     ctxt � m   � � � � � � �  . / M u s i c / i T u n e s�T  �V  �U   � �R ��Q
�R 
Equa � l  � � ��P�O � m   � � � � � � �  M u s i c / i T u n e s�P  �O  �Q  �Z   �  �  � l     �N�M�L�N  �M  �L     i     I      �K�J�I�K 0 test_joinpath test_joinPath�J  �I   k     }  I    "�H	 z�G 
�G .���:AsRenull��� ��� null�H  	 �F

�F 
Valu
 l  	 �E�D I  	 �C z�B 
�B .Fil:JoiPnull���     **** J      m     �  /  m     � 
 U s e r s  m     �  j s m i t h �A m     �  D e s k t o p�A  �C  �E  �D   �@�?
�@ 
Equa l    �>�=  m    !! �"" * / U s e r s / j s m i t h / D e s k t o p�>  �=  �?   #$# I  # M%�<&% z�; 
�; .���:AsRenull��� ��� null�<  & �:'(
�: 
Valu' l  , D)�9�8) I  , D*+,* z�7 
�7 .Fil:JoiPnull���     ****+ J   3 9-- ./. m   3 400 �11  D o c u m e n t s/ 2�62 m   4 733 �44  R e a d M e�6  , �55�4
�5 
Exte5 m   < ?66 �77  t x t�4  �9  �8  ( �38�2
�3 
Equa8 l  E H9�1�09 m   E H:: �;; ( D o c u m e n t s / R e a d M e . t x t�1  �0  �2  $ <�/< I  N }=�.>= z�- 
�- .���:AsRenull��� ��� null�.  > �,?@
�, 
Valu? l  Y tA�+�*A I  Y tBC�)B z�( 
�( .Fil:JoiPnull���     ****C J   b oDD EFE 4   b j�'G
�' 
psxfG m   f iHH �II  / U s e r s / j s m i t hF J�&J m   j mKK �LL ( D o c u m e n t s / R e a d M e . t x t�&  �)  �+  �*  @ �%M�$
�% 
EquaM l  u xN�#�"N m   u xOO �PP D / U s e r s / j s m i t h / D o c u m e n t s / R e a d M e . t x t�#  �"  �$  �/   QRQ l     �!� ��!  �   �  R STS i  ! $UVU I      ����  0 test_splitpath test_splitPath�  �  V k     �WW XYX I     Z�[Z z� 
� .���:AsRenull��� ��� null�  [ �\]
� 
Valu\ l  	 ^��^ I  	 _`�_ z� 
� .Fil:SplPnull���     ctxt` m    aa �bb D / U s e r s / j s m i t h / D o c u m e n t s / R e a d M e . t x t�  �  �  ] �c�
� 
Equac l   d��d J    ee fgf m    hh �ii . / U s e r s / j s m i t h / D o c u m e n t sg j�j m    kk �ll  R e a d M e . t x t�  �  �  �  Y mnm I  ! Wo�po z� 
� .���:AsRenull��� ��� null�  p �qr
� 
Valuq l  * >s��s I  * >tuvt z�
 
�
 .Fil:SplPnull���     ctxtu l  1 5w�	�w 4   1 5�x
� 
psxfx m   3 4yy �zz D / U s e r s / j s m i t h / D o c u m e n t s / R e a d M e . t x t�	  �  v �{�
� 
Upon{ m   6 9|| z� 
� FLSPFLSA�  �  �  r �}�
� 
Equa} l  ? R~�� ~ J   ? R ��� m   ? B�� ���  /� ��� m   B E�� ��� 
 U s e r s� ��� m   E H�� ���  j s m i t h� ��� m   H K�� ���  D o c u m e n t s� ���� m   K N�� ���  R e a d M e . t x t��  �  �   �  n ���� I  X ������ z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  c x������ I  c x���� z�� 
�� .Fil:SplPnull���     ctxt� m   l o�� ��� D / U s e r s / j s m i t h / D o c u m e n t s / R e a d M e . t x t� �����
�� 
Upon� m   p s�� z�� 
�� FLSPFLSE��  ��  ��  � �����
�� 
Equa� l  y ������� J   y ��� ��� m   y |�� ��� < / U s e r s / j s m i t h / D o c u m e n t s / R e a d M e� ���� m   | �� ���  t x t��  ��  ��  ��  ��  T ���� l     ��������  ��  ��  ��    ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� h   , 3����� *0 suite_readwritefile suite_ReadWriteFile� l     ������  �   TO DO: implement   � ��� "   T O   D O :   i m p l e m e n t� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� h   4 ;����� 40 suite_shellscriptsupport suite_ShellScriptSupport� k      �� ��� l     ��������  ��  ��  � ��� j     -����� 0 	_options1  � J     ,�� ��� l 	   ������ K     �� ������ 0 propertyname propertyName� m    �� ���  a b l e� ������� 0 	shortname 	shortName� m    �� ���  a��  ��  ��  � ��� l 	  ������ K    �� ������ 0 propertyname propertyName� m    �� ��� 
 b a k e r� ������� 0 longname longName� m   	 
�� ��� 
 b a k e r��  ��  ��  � ��� l 	  ������ K    �� ������ 0 propertyname propertyName� m    �� ���  c h a r l i e� ������ 0 	shortname 	shortName� m    �� ���  c� ������ 0 longname longName� m    �� ���  c h a r� ������� 0 	valuetype 	valueType� m    ��
�� 
long��  ��  ��  � ���� l 	  *������ K    *�� ������ 0 propertyname propertyName� m    �� ��� 
 d e l t a� ������ 0 	shortname 	shortName� m    �� ���  d� ������ 0 	valuetype 	valueType� m    ��
�� 
long� ������ 0 defaultvalue defaultValue� m     ������� ������� $0 valueplaceholder valuePlaceholder� m   # &�� ���  B A Z��  ��  ��  ��  �    l     ��������  ��  ��    j   . 2���� 0 _options1_description   m   . 1 � � 
 O P T I O N S 
 
     - a   T E X T 
 
     - - b a k e r   T E X T 
 
     - c ,   - - c h a r   I N T E G E R 
 
     - d   B A Z 
             D e f a u l t :    - 1  .   
  j   3 7��	�� >0 _options1_descriptiondefaults _options1_descriptionDefaults	 m   3 6

 � � 
     - h ,   - - h e l p 
             P r i n t   t h i s   h e l p   a n d   e x i t . 
 
     - v ,   - - v e r s i o n 
             P r i n t   v e r s i o n   n u m b e r   a n d   e x i t . 
  l     ��������  ��  ��    j   8 Q���� 0 _arguments1   J   8 P  l 	 8 >���� K   8 > ������ 0 propertyname propertyName m   9 < �  f i r s t A r g��  ��  ��   �� l 	 > N���� K   > N ���� 0 propertyname propertyName m   ? B �  r e s t A r g s �� !�� 0 	valuetype 	valueType  m   C F��
�� 
file! ��"���� 0 islist isList" m   I J��
�� boovtrue��  ��  ��  ��   #$# l     ��������  ��  ��  $ %&% j   R V��'�� 0 _arguments1_description  ' m   R U(( �)) � 
 A R G U M E N T S 
 
     T E X T 
 
     F I L E   . . . 
             T h i s   a r g u m e n t   c a n   a p p e a r   m u l t i p l e   t i m e s .   
& *+* l     ��������  ��  ��  + ,-, l     ��������  ��  ��  - ./. i  W Z010 I      �������� "0 test_formathelp test_formatHelp��  ��  1 k    22 343 l     ��56��  5 Q K TO DO: also test with args only, opts ony, without summary/default options   6 �77 �   T O   D O :   a l s o   t e s t   w i t h   a r g s   o n l y ,   o p t s   o n y ,   w i t h o u t   s u m m a r y / d e f a u l t   o p t i o n s4 898 l     ��������  ��  ��  9 :;: I    %<��=< z�� 
�� .���:AsRenull��� ��� null��  = ��>?
�� 
Valu> l  	 @����@ I  	 A��BA z�� 
�� .Fil:FHlpnull��� ��� null��  B ��CD
�� 
NameC m    EE �FF  f o o - b a rD ��GH
�� 
VFmtG m    ��
�� boovfalsH ��G��
�� 
DefO��  ��  ��  ? ��IJ
�� 
EquaI l   K����K m    LL �MM J N A M E 
 
     f o o - b a r 
 
 S Y N O P S I S 
 
     f o o - b a r 
��  ��  J �N�~
� 
SummN m     OO �PP * m i n i m u m   d o c u m e n t a t i o n�~  ; QRQ l  & &�}�|�{�}  �|  �{  R STS I  & lU�zVU z�y 
�y .���:AsRenull��� ��� null�z  V �xWX
�x 
ValuW l  / UY�w�vY I  / UZ�u[Z z�t 
�t .Fil:FHlpnull��� ��� null�u  [ �s\]
�s 
Name\ m   : =^^ �__  f o o - b a r] �r`a
�r 
OpsA` K   @ Nbb �qcd�q 0 propertyname propertyNamec m   C Fee �ff  a r g u m e n t s L i s td �pg�o�p 0 islist isListg m   I J�n
�n boovtrue�o  a �mh�l
�m 
VFmth m   O P�k
�k boovfals�l  �w  �v  X �jij
�j 
Equai l  V ck�i�hk b   V clml b   V _non m   V Ypp �qq � N A M E 
 
     f o o - b a r 
 
 S Y N O P S I S 
 
     f o o - b a r   [ - h v ]   [ - - ]   T E X T   . . . 
 
 O P T I O N S 
o o   Y ^�g�g >0 _options1_descriptiondefaults _options1_descriptionDefaultsm m   _ brr �ss � 
 A R G U M E N T S 
 
     T E X T   . . . 
             T h i s   a r g u m e n t   c a n   a p p e a r   m u l t i p l e   t i m e s .   
�i  �h  j �ft�e
�f 
Summt m   d guu �vv � f o r m a t   h e l p   f o r   d e f a u l t   - h   a n d   - v   o p t i o n s   a n d   l i s t   o f   o n e   o r   m o r e   a r g u m e n t s�e  T wxw l  m m�d�c�b�d  �c  �b  x yzy l  m m�a�`�_�a  �`  �_  z {|{ I  m �}�^~} z�] 
�] .���:AsRenull��� ��� null�^  ~ �\�
�\ 
Valu l  x ���[�Z� I  x ���Y�� z�X 
�X .Fil:FHlpnull��� ��� null�Y  � �W��
�W 
Name� m   � ��� ���  f o o - b a r� �V��
�V 
OpsA� K   � ��� �U���U 0 propertyname propertyName� m   � ��� ���  a r g u m e n t s L i s t� �T���T 0 islist isList� m   � ��S
�S boovtrue� �R��Q�R 0 defaultvalue defaultValue� J   � ��P�P  �Q  � �O��N
�O 
VFmt� m   � ��M
�M boovfals�N  �[  �Z  � �L��
�L 
Equa� l  � ���K�J� b   � ���� b   � ���� m   � ��� ��� � N A M E 
 
     f o o - b a r 
 
 S Y N O P S I S 
 
     f o o - b a r   [ - h v ]   [ - - ]   [ T E X T   . . . ] 
 
 O P T I O N S 
� o   � ��I�I >0 _options1_descriptiondefaults _options1_descriptionDefaults� m   � ��� ��� � 
 A R G U M E N T S 
 
     T E X T   . . . 
             T h i s   a r g u m e n t   c a n   a p p e a r   m u l t i p l e   t i m e s .   
�K  �J  � �H��G
�H 
Summ� m   � ��� ��� � f o r m a t   h e l p   f o r   d e f a u l t   - h   a n d   - v   o p t i o n s   a n d   l i s t   o f   z e r o   o r   m o r e   a r g u m e n t s�G  | ��� l  � ��F�E�D�F  �E  �D  � ��C� I  ���B�� z�A 
�A .���:AsRenull��� ��� null�B  � �@��
�@ 
Valu� l  � ���?�>� I  � ���=�� z�< 
�< .Fil:FHlpnull��� ��� null�=  � �;��
�; 
Name� m   � ��� ���  f o o - b a r� �:��
�: 
OpsD� o   � ��9�9 0 	_options1  � �8��
�8 
OpsA� o   � ��7�7 0 _arguments1  � �6��
�6 
Summ� m   � ��� ��� , s h o r t   d e s c r i p t i v e   t e x t� �5��4
�5 
VFmt� m   � ��3
�3 boovfals�4  �?  �>  � �2��1
�2 
Equa� l  ���0�/� b   ���� b   � ���� b   � ���� m   � ��� ���  N A M E 
 
     f o o - b a r   - -   s h o r t   d e s c r i p t i v e   t e x t 
 
 S Y N O P S I S 
 
     f o o - b a r   [ - h v ]   - a   T E X T   - b a k e r   T E X T   - c   I N T E G E R   [ - d   B A Z ]   [ - - ]   T E X T   F I L E   . . . 
� o   � ��.�. 0 _options1_description  � o   � ��-�- >0 _options1_descriptiondefaults _options1_descriptionDefaults� o   ��,�, 0 _arguments1_description  �0  �/  �1  �C  / ��� l     �+�*�)�+  �*  �)  � ��� i  [ ^��� I      �(�'�&�( *0 test_parsearguments test_parseArguments�'  �&  � k     ��� ��� I    #��%�� z�$ 
�$ .���:AsRenull��� ��� null�%  � �#��
�# 
Valu� l  	 ��"�!� I  	 ��� � z� 
� .Fil:Argvnull���     ****� J    ��  �   �"  �!  � ���
� 
Equa� K    �� ���� 0 help  � m    �
� boovfals� ���� 0 version  � m    �
� boovfals�  �  � ��� I  $ M���� z� 
� .���:AsRenull��� ��� null�  � ���
� 
Valu� l  - =���� I  - =���� z� 
� .Fil:Argvnull���     ****� J   4 8�� ��� m   4 5�� ���  - h� ��� m   5 6�� ���  - v�  �  �  �  � ���
� 
Equa� K   > D�� ���� 0 help  � m   ? @�
� boovtrue� ���
� 0 version  � m   A B�	
�	 boovfals�
  � ���
� 
Summ� m   E F�� ��� � p a r s e r   s h o u l d   r e t u r n   a s   s o o n   a s   a   d e f a u l t   - h   o p t i o n   i s   e n c o u n t e r e d ,   i g n o r i n g   r e m a i n i n g   a r g s�  � ��� l  N ����� I  N ����� z� 
� .���:AsRenull��� ��� null�  � ���
� 
Valu� l  Y o���� I  Y o���� z�  
�  .Fil:Argvnull���     ****� J   b j�� ��� m   b e   �  - v� �� m   e h �  - h��  �  �  �  � ��
�� 
Equa K   p v ��	�� 0 help   m   q r��
�� boovfals	 ��
���� 0 version  
 m   s t��
�� boovtrue��   ����
�� 
Summ m   w z � � p a r s e r   s h o u l d   r e t u r n   a s   s o o n   a s   a   d e f a u l t   - v   o p t i o n   i s   e n c o u n t e r e d ,   i g n o r i n g   r e m a i n i n g   a r g s��  � [ U TO DO: also need to test when -h/-v is overridden by custom option definition record   � � �   T O   D O :   a l s o   n e e d   t o   t e s t   w h e n   - h / - v   i s   o v e r r i d d e n   b y   c u s t o m   o p t i o n   d e f i n i t i o n   r e c o r d�  I  � ��� z�� 
�� .���:AsRenull��� ��� null��   ��
�� 
Valu l  � ����� I  � � z�� 
�� .Fil:Argvnull���     **** J   � �  m   � � �  f o o �� m   � � �    b a r��   ��!��
�� 
OpsA! K   � �"" ��#$�� 0 propertyname propertyName# m   � �%% �&&  a r g u m e n t s L i s t$ ��'���� 0 islist isList' m   � ���
�� boovtrue��  ��  ��  ��   ��(��
�� 
Equa( K   � �)) ��*+�� 0 help  * m   � ���
�� boovfals+ ��,-�� 0 version  , m   � ���
�� boovfals- ��.���� 0 argumentslist argumentsList. J   � �// 010 m   � �22 �33  f o o1 4��4 m   � �55 �66  b a r��  ��  ��   7��7 I  � �8��98 z�� 
�� .���:AsErnull��� ��� null��  9 ��:;
�� 
Args: J   � �<< =>= J   � �����  > ?@? J   � �����  @ A��A K   � �BB ��CD�� 0 propertyname propertyNameC m   � �EE �FF  a r g u m e n t s L i s tD ��G���� 0 islist isListG m   � ���
�� boovtrue��  ��  ; ��H��
�� 
EquaH K   � �II ��JK�� 0 errornumber errorNumberJ m   � �����'K ��L���� 0 errormessage errorMessageL m   � �MM �NN \ M i s s i n g   1 s t   r e q u i r e d   a r g u m e n t   ( e x p e c t e d   T E X T ) .��  ��  ��  � OPO l     ��������  ��  ��  P QRQ i  _ bSTS I      ��U���� *0 call_parsearguments call_parseArgumentsU V��V J      WW XYX o      ���� 0 argslist argsListY Z[Z o      ���� 0 optdefs optDefs[ \��\ o      ���� 0 argdefs argDefs��  ��  ��  T I    ]^_] z�� 
�� .Fil:Argvnull���     ****^ o    ���� 0 argslist argsList_ ��`a
�� 
OpsD` o   	 
���� 0 optdefs optDefsa ��b��
�� 
OpsAb o    ���� 0 argdefs argDefs��  R c��c l     ��������  ��  ��  ��  � ded l     ��������  ��  ��  e fgf l     ��������  ��  ��  g hih i   < ?jkj I     ������
�� .aevtoappnull  �   � ****��  ��  k l    lmnl I    op��o z�� 
�� .���:RunTnull���     filep l   q����q I   ��r��
�� .earsffdralis        afdrr  f    ��  ��  ��  ��  m N H including this command allows tests to be run directly in Script Editor   n �ss �   i n c l u d i n g   t h i s   c o m m a n d   a l l o w s   t e s t s   t o   b e   r u n   d i r e c t l y   i n   S c r i p t   E d i t o ri tut l     ��������  ��  ��  u v��v l     ��������  ��  ��  ��       ��wxyz{|��  w ����������
�� 
pimr�� 00 suite_pathmanipulation suite_PathManipulation�� *0 suite_readwritefile suite_ReadWriteFile�� 40 suite_shellscriptsupport suite_ShellScriptSupport
�� .aevtoappnull  �   � ****x ��}�� }  ~�~ �����
�� 
cobj� ��   �� 	
�� 
scpt��   �����
�� 
cobj� ��   ��
�� 
osax��  � �����
�� 
cobj� ��   �� 
�� 
scpt��  y ��    ��� 00 suite_pathmanipulation suite_PathManipulation� 
���������������  � ����������������
�� 
pimr�� 0 	_username 	_userName�� 0 	_userhome 	_userHome�� "0 configure_setup configure_setUp�� $0 test_convertpath test_convertPath�� (0 test_normalizepath test_normalizePath�� 0 test_joinpath test_joinPath��  0 test_splitpath test_splitPath� ����� �  �� �����
�� 
cobj� ��   �� &
�� 
frmk��  
�� 
msng
�� 
msng� �� 5���������� "0 configure_setup configure_setUp��  ��  �  � 	 J����~�}�|�{�z�y
�� 
home
� 
pnam
�~ 
alis
�} 
psxp
�| misccura�{ 0 nsfilemanager NSFileManager�z  0 defaultmanager defaultManager�y :0 changecurrentdirectorypath_ changeCurrentDirectoryPath_�� 0� *�,�,Ec  O*�,�&�,Ec  UO��,j+ b  k+ � �x ]�w�v���u�x $0 test_convertpath test_convertPath�w  �v  �  � �t 	�s  i�r�q�p�o o�n�m 	  {�l � 	  ��k�j � 	  ��i �
�t 
scpt
�s 
Valu
�r 
To__
�q FLCTFLCH
�p .Fil:ConPnull���     ****
�o 
Equa�n 
�m .���:AsRenull��� ��� null
�l 
From
�k FLCTFLCX
�j 
psxf
�i FLCTFLCU�u �)��/ *�)��/ 	���l U��� UO)��/ *�)��/ 	���l U�a � UO)�a / &*�)�a / a �a l U�)a a /� UO)�a / &*�)�a / )a a /�a l U�a � U� �h ��g�f���e�h (0 test_normalizepath test_normalizePath�g  �f  �  � �d 	�c  ��b�a�` � ��_�^ 	  ��] � � 	  � ��\ ��[ 	  � �
�d 
scpt
�c 
Valu
�b 
ExpT
�a .Fil:NorPnull���     ctxt
�` 
Equa�_ 
�^ .���:AsRenull��� ��� null
�] 
ExpR
�\ 
Summ�[ �e �)��/ !*�)��/ 	��el U��b  %�%� UO)��/ %*�)��/ 	��el U�a b  %a %� UO)�a / %*�)�a / 	a j U�a a a a  UO)�a / *�)�a / 	a j U�a � U� �Z�Y�X���W�Z 0 test_joinpath test_joinPath�Y  �X  �  � �V 	�U �T�S�R!�Q 	 03�P6: 	 �OHKO
�V 
scpt
�U 
Valu�T 
�S .Fil:JoiPnull���     ****
�R 
Equa
�Q .���:AsRenull��� ��� null
�P 
Exte
�O 
psxf�W ~)��/ *�)��/ �����vj 	U��� UO)��/ $*�)��/ �a lva a l 	U�a � UO)�a / '*�)�a / )a a /a lvj 	U�a � U� �NV�M�L���K�N  0 test_splitpath test_splitPath�M  �L  �  � �J 	�I a�H�Ghk�F�E 	 �Dy�C�B������A 	 ��@��
�J 
scpt
�I 
Valu
�H .Fil:SplPnull���     ctxt
�G 
Equa�F 
�E .���:AsRenull��� ��� null
�D 
psxf
�C 
Upon
�B FLSPFLSA�A 
�@ FLSPFLSE�K �)��/ *�)��/ �j U���lv� 
UO)��/ 0*�)��/ )��/�a l U�a a a a a a v� 
UO)�a / &*�)�a / a �a l U�a a lv� 
Uz �?�  ��? *0 suite_readwritefile suite_ReadWriteFile� �>��>  �  { �=�  ��= 40 suite_shellscriptsupport suite_ShellScriptSupport� 
�<��
�(����<  � �;�:�9�8�7�6�5�4�; 0 	_options1  �: 0 _options1_description  �9 >0 _options1_descriptiondefaults _options1_descriptionDefaults�8 0 _arguments1  �7 0 _arguments1_description  �6 "0 test_formathelp test_formatHelp�5 *0 test_parsearguments test_parseArguments�4 *0 call_parsearguments call_parseArguments� �3��3 �  ����� �2���2 0 propertyname propertyName� �1��0�1 0 	shortname 	shortName�0  � �/���/ 0 propertyname propertyName� �.��-�. 0 longname longName�-  � �,���, 0 propertyname propertyName� �+���+ 0 	shortname 	shortName� �*���* 0 longname longName� �)�(�'�) 0 	valuetype 	valueType
�( 
long�'  � �&���& 0 propertyname propertyName� �%���% 0 	shortname 	shortName� �$�#��$ 0 	valuetype 	valueType
�# 
long� �"�!��" 0 defaultvalue defaultValue�!��� � ���  $0 valueplaceholder valuePlaceholder�  � ��� �  ��� ��� 0 propertyname propertyName�  � ��� 0 propertyname propertyName� ���� 0 	valuetype 	valueType
� 
file� ���� 0 islist isList
� boovtrue�  � �1������ "0 test_formathelp test_formatHelp�  �  �  � )� 	� �E�����
L�	O� 	 ^��e��pru 	 ������ 	 �����
� 
scpt
� 
Valu
� 
Name
� 
VFmt
� 
DefO� 
� .Fil:FHlpnull��� ��� null
�
 
Equa
�	 
Summ
� .���:AsRenull��� ��� null
� 
OpsA� 0 propertyname propertyName� 0 islist isList� � 0 defaultvalue defaultValue
� 
OpsD� 
�)��/ *�)��/ *���f�f� 	U����� UO)��/ @*�)�a / *�a a a a a ea �f� 	U�a b  %a %�a � UO)�a / C*�)�a / !*�a a a a a ea jv��f� 	U�a b  %a  %�a !� UO)�a "/ K*�)�a #/ #*�a $a %b   a b  �a &�fa ' 	U�a (b  %b  %b  %a  U� � ����������  *0 test_parsearguments test_parseArguments��  ��  �  � )�� 	�� ������������ 	 ������� 	   	 ����%����25 	��E������M��
�� 
scpt
�� 
Valu
�� .Fil:Argvnull���     ****
�� 
Equa�� 0 help  �� 0 version  �� 
�� .���:AsRenull��� ��� null
�� 
Summ�� 
�� 
OpsA�� 0 propertyname propertyName�� 0 islist isList�� 0 argumentslist argumentsList
�� 
Args�� 0 errornumber errorNumber��'�� 0 errormessage errorMessage
�� .���:AsErnull��� ��� null�� )��/ *�)��/ jvj U��f�f�� 	UO)��/ #*�)��/ 
��lvj U��e�f���a  	UO)�a / +*�)�a / a a lvj U��f�e��a a  	UO)�a / A*�)�a / a a lva a a a e�l U��f�fa a a  lva � 	UO)�a !/ +*a "jvjva a #a e�mv�a $a %a &a '�� (U� ��T���������� *0 call_parsearguments call_parseArguments�� ����� �  �� ����� �  �������� 0 argslist argsList�� 0 optdefs optDefs�� 0 argdefs argDefs��  � �������� 0 argslist argsList�� 0 optdefs optDefs�� 0 argdefs argDefs� �� ��������
�� 
scpt
�� 
OpsD
�� 
OpsA�� 
�� .Fil:Argvnull���     ****�� )��/ ���� U| ��k��������
�� .aevtoappnull  �   � ****��  ��  �  � �� 	����
�� 
scpt
�� .earsffdralis        afdr
�� .���:RunTnull���     file�� )��/ )j j U ascr  ��ޭ