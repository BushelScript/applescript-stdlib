FasdUAS 1.101.10   ��   ��    k             x     �� ����    4   % )�� 
�� 
scpt  m   ' ( 	 	 � 
 
  T e s t L i b��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l          x    $�� ����    4   . 2�� 
�� 
scpt  m   0 1   �    T e x t L i b��      the script being tested     �   0   t h e   s c r i p t   b e i n g   t e s t e d      l     ��������  ��  ��        l     ��������  ��  ��        h   $ +��  �� $0 suite_modifytext suite_ModifyText   k       ! !  " # " l      �� $ %��   $2,	to configure_skipTests()		return "checking suite skipping works" -- skip all tests in this suite		return {test_uppercase:"checking per-test skipping works", test_lowercase:missing value} -- skip 'test_uppercase only'		return missing value -- do all tests in this suite	end configure_skipTests	    % � & &X  	 t o   c o n f i g u r e _ s k i p T e s t s ( )  	 	 r e t u r n   " c h e c k i n g   s u i t e   s k i p p i n g   w o r k s "   - -   s k i p   a l l   t e s t s   i n   t h i s   s u i t e  	 	 r e t u r n   { t e s t _ u p p e r c a s e : " c h e c k i n g   p e r - t e s t   s k i p p i n g   w o r k s " ,   t e s t _ l o w e r c a s e : m i s s i n g   v a l u e }   - -   s k i p   ' t e s t _ u p p e r c a s e   o n l y '  	 	 r e t u r n   m i s s i n g   v a l u e   - -   d o   a l l   t e s t s   i n   t h i s   s u i t e  	 e n d   c o n f i g u r e _ s k i p T e s t s  	 #  ' ( ' i     ) * ) I      �������� 0 test_uppercase  ��  ��   * k     � + +  , - , I     .�� / . z�� 
�� .���:AsRenull��� ��� null��   / �� 0 1
�� 
Valu 0 l  	  2���� 2 I  	  3 4�� 3 z�� 
�� .Txt:UppTnull���     ctxt 4 m     5 5 � 6 6  f o � b � r��  ��  ��   1 �� 7��
�� 
Equa 7 m     8 8 � 9 9  F O � B � R��   -  : ; : I   = <�� = < z�� 
�� .���:AsRenull��� ��� null��   = �� > ?
�� 
Valu > l  ' 4 @���� @ I  ' 4 A B�� A z�� 
�� .Txt:UppTnull���     ctxt B m   . / C C @      ��  ��  ��   ? �� D��
�� 
Equa D l  5 8 E���� E c   5 8 F G F m   5 6 H H @       G m   6 7��
�� 
ctxt��  ��  ��   ;  I�� I X   > � J�� K J I  \ | L�� M L z�� 
�� .���:AsErnull��� ��� null��   M �� N O
�� 
Args N n  i n P Q P 1   j n��
�� 
pcnt Q o   i j���� 0 aref aRef O �� R��
�� 
Equa R K   o w S S �� T���� 0 errornumber errorNumber T m   r u�����Y��  ��  �� 0 aref aRef K J   A L U U  V W V K   A E X X �� Y���� 0 a   Y m   B C Z Z � [ [  f o o��   W  \�� \ J   E J ] ]  ^�� ^ 1   E H��
�� 
ascr��  ��  ��   (  _ ` _ l     ��������  ��  ��   `  a b a i    c d c I      �������� 0 test_lowercase  ��  ��   d k     [ e e  f g f I     h�� i h z�� 
�� .���:AsRenull��� ��� null��   i �� j k
�� 
Valu j l  	  l���� l I  	  m n�� m z�� 
�� .Txt:LowTnull���     ctxt n m     o o � p p  F O � B � R��  ��  ��   k �� q��
�� 
Equa q m     r r � s s  f o � b � r��   g  t�� t X    [ u�� v u I  6 V w�� x w z�� 
�� .���:AsErnull��� ��� null��   x �� y z
�� 
Args y n  C H { | { 1   D H��
�� 
pcnt | o   C D���� 0 aref aRef z �� }��
�� 
Equa } K   I Q ~ ~ �� ���� 0 errornumber errorNumber  m   L O�����Y��  ��  �� 0 aref aRef v J   ! * � �  � � � K   ! % � � �� ����� 0 a   � m   " # � � � � �  f o o��   �  ��� � J   % ( � �  ��� � 1   % &��
�� 
ascr��  ��  ��   b  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� 0 test_capitalize  ��  ��   � k     [ � �  � � � I     ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  	  ����� � I  	  � ��� � z�� 
�� .Txt:CapTnull���     ctxt � m     � � � � �  F O � B � R��  ��  ��   � �� ���
�� 
Equa � m     � � � � �  F o � b � r��   �  ��� � X    [ ��� � � I  6 V ��� � � z�� 
�� .���:AsErnull��� ��� null��   � �� � �
�� 
Args � n  C H � � � 1   D H��
�� 
pcnt � o   C D���� 0 aref aRef � �� ���
�� 
Equa � K   I Q � � �� ����� 0 errornumber errorNumber � m   L O�����Y��  ��  �� 0 aref aRef � J   ! * � �  � � � K   ! % � � �� ����� 0 a   � m   " # � � � � �  f o o��   �  ��� � J   % ( � �  ��� � 1   % &��
�� 
ascr��  ��  ��   �  � � � l     �������  ��  �   �  � � � i    � � � I      �~ ��}�~ 0 call_uppercase   �  ��| � o      �{�{ 	0 param  �|  �}   � I     � ��z � z�y 
�y .Txt:UppTnull���     ctxt � o    �x�x 	0 param  �z   �  � � � l     �w�v�u�w  �v  �u   �  � � � i    � � � I      �t ��s�t 0 call_lowercase   �  ��r � o      �q�q 	0 param  �r  �s   � I     � ��p � z�o 
�o .Txt:LowTnull���     ctxt � o    �n�n 	0 param  �p   �  � � � l     �m�l�k�m  �l  �k   �  � � � i    � � � I      �j ��i�j 0 call_capitalize   �  ��h � o      �g�g 	0 param  �h  �i   � I     � ��f � z�e 
�e .Txt:CapTnull���     ctxt � o    �d�d 	0 param  �f   �  ��c � l     �b�a�`�b  �a  �`  �c     � � � l     �_�^�]�_  �^  �]   �  � � � l     �\�[�Z�\  �[  �Z   �  � � � h   , 3�Y ��Y $0 suite_formattext suite_FormatText � k       � �  � � � l     �X�W�V�X  �W  �V   �  � � � j     �U ��U 	0 _date   � m     �T
�T 
msng �  � � � j    �S ��S 0 	_testdata 	_testData � m    �R
�R 
msng �  � � � l     �Q�P�O�Q  �P  �O   �  � � � i   	 � � � I      �N�M�L�N "0 configure_setup configure_setUp�M  �L   � k     @ � �  � � � r      � � � I    �K�J�I
�K .misccurdldt    ��� null�J  �I   � o      �H�H 	0 _date   �  ��G � r    @ � � � J    : � �  � � � l 	   ��F�E � J     � �  � � � l    ��D�C � m     � � @�������D  �C   �  ��B � l    ��A�@ � c     � � � m     � � @������ � m    �?
�? 
ctxt�A  �@  �B  �F  �E   �    l 	  �>�= J      l   �<�; m     �  �<  �;   	�:	 l   
�9�8
 m     �  " "�9  �8  �:  �>  �=    l 	  +�7�6 J    +  l    �5�4 J       m     �  f o o  m    �3�3   m    �2
�2 boovtrue �1 o    �0�0 	0 _date  �1  �5  �4   �/ l    )�.�- b     ) !  b     '"#" m     !$$ �%% . { " f o o " ,   1 ,   t r u e ,   d a t e   "# o   ! &�,�, 	0 _date  ! m   ' (&& �''  " }�.  �-  �/  �7  �6   (�+( l 	 + 8)�*�)) l 
 + 8*�(�'* J   + 8++ ,-, l  + 3.�&�%. K   + 3// �$01�$ 0 a  0 m   , -�#
�# 
msng1 �"23
�" 
pnam2 m   . /�!
�! 
alis3 � 4�
�  
pcls4 m   0 1�
� 
docu�  �&  �%  - 5�5 l  3 66��6 m   3 677 �88 Z { a : m i s s i n g   v a l u e ,   n a m e : a l i a s ,   c l a s s : d o c u m e n t }�  �  �  �(  �'  �*  �)  �+   � o      �� 0 	_testdata 	_testData�G   � 9:9 l     ����  �  �  : ;<; i  
 =>= I      ���� 80 test_literalrepresentation test_literalRepresentation�  �  > X     I?�@? k    DAA BCB r    $DED o    �� 0 aref aRefE J      FF GHG o      �� 0 avalue aValueH I�I o      ��  0 expectedresult expectedResult�  C J�J I  % DK�LK z� 
� .���:AsRenull��� ��� null�  L �MN
� 
ValuM l  . =O�
�	O I  . =P�QP z� 
� .Txt:FLitnull��� ��� null�  Q �R�
� 
For_R o   7 8�� 0 avalue aValue�  �
  �	  N �S�
� 
EquaS o   > ?��  0 expectedresult expectedResult�  �  � 0 aref aRef@ o    � �  0 	_testdata 	_testData< T��T l     ��������  ��  ��  ��   � UVU l     ��������  ��  ��  V WXW l     ��������  ��  ��  X YZY i   4 7[\[ I     ������
�� .aevtoappnull  �   � ****��  ��  \ l    ]^_] I    ��`��
�� .sysoexecTEXT���     TEXT` b     aba m     cc �dd  ~ / b i n / o s a t e s t  b n    
efe 1    
��
�� 
strqf n    ghg 1    ��
�� 
psxph l   i����i I   ��j��
�� .earsffdralis        afdrj  f    ��  ��  ��  ��  ^ [ U handy for running tests in Script Editor (assumes `osatest` is installed in `~/bin`)   _ �kk �   h a n d y   f o r   r u n n i n g   t e s t s   i n   S c r i p t   E d i t o r   ( a s s u m e s   ` o s a t e s t `   i s   i n s t a l l e d   i n   ` ~ / b i n ` )Z lml l     ��������  ��  ��  m n��n l     ��������  ��  ��  ��       ��opqrs��  o ��������
�� 
pimr�� $0 suite_modifytext suite_ModifyText�� $0 suite_formattext suite_FormatText
�� .aevtoappnull  �   � ****p ��t�� t  uvwu ��x��
�� 
cobjx yy   �� 	
�� 
scpt��  v ��z��
�� 
cobjz {{   ��
�� 
osax��  w ��|��
�� 
cobj| }}   �� 
�� 
scpt��  q ��    ~�� $0 suite_modifytext suite_ModifyText~ ����������   �������������� 0 test_uppercase  �� 0 test_lowercase  �� 0 test_capitalize  �� 0 call_uppercase  �� 0 call_lowercase  �� 0 call_capitalize  � �� *���������� 0 test_uppercase  ��  ��  � ���� 0 aref aRef� �� 	��  5���� 8���� 	  C���� Z�������� 	����������
�� 
scpt
�� 
Valu
�� .Txt:UppTnull���     ctxt
�� 
Equa�� 
�� .���:AsRenull��� ��� null
�� 
ctxt�� 0 a  
�� 
ascr
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
Args
�� 
pcnt�� 0 errornumber errorNumber���Y
�� .���:AsErnull��� ��� null�� �)��/ *�)��/ �j U��� 	UO)��/ *�)��/ �j U���&� 	UO B��l_ kvlv[a a l kh  )�a / *a �a ,�a a l� U[OY��� �� d���������� 0 test_lowercase  ��  ��  � ���� 0 aref aRef� �� 	��  o���� r������ ��������� 	����������
�� 
scpt
�� 
Valu
�� .Txt:LowTnull���     ctxt
�� 
Equa�� 
�� .���:AsRenull��� ��� null�� 0 a  
�� 
ascr
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
Args
�� 
pcnt�� 0 errornumber errorNumber���Y
�� .���:AsErnull��� ��� null�� \)��/ *�)��/ �j U��� 	UO <��l�kvlv[��l kh  )�a / *a �a ,�a a l� U[OY��� �� ����������� 0 test_capitalize  ��  ��  � ���� 0 aref aRef� �� 	��  ����� ������� ��������� 	����������
�� 
scpt
�� 
Valu
�� .Txt:CapTnull���     ctxt
�� 
Equa�� 
�� .���:AsRenull��� ��� null�� 0 a  
�� 
ascr
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
Args
�� 
pcnt�� 0 errornumber errorNumber���Y
�� .���:AsErnull��� ��� null�� \)��/ *�)��/ �j U��� 	UO <��l�kvlv[��l kh  )�a / *a �a ,�a a l� U[OY��� �� ����������� 0 call_uppercase  �� ����� �  ���� 	0 param  ��  � ���� 	0 param  � �� ��
�� 
scpt
�� .Txt:UppTnull���     ctxt�� )��/ �j U� �� ����������� 0 call_lowercase  �� ��� �  �~�~ 	0 param  ��  � �}�} 	0 param  � �| �{
�| 
scpt
�{ .Txt:LowTnull���     ctxt�� )��/ �j U� �z ��y�x���w�z 0 call_capitalize  �y �v��v �  �u�u 	0 param  �x  � �t�t 	0 param  � �s �r
�s 
scpt
�r .Txt:CapTnull���     ctxt�w )��/ �j Ur �q �  ��q $0 suite_formattext suite_FormatText� �p��o�n���p  � �m�l�k�j�m 	0 _date  �l 0 	_testdata 	_testData�k "0 configure_setup configure_setUp�j 80 test_literalrepresentation test_literalRepresentation
�o 
msng
�n 
msng� �i ��h�g���f�i "0 configure_setup configure_setUp�h  �g  �  � �e ��d�c$&�b�a�`�_�^�]�\7
�e .misccurdldt    ��� null
�d 
ctxt�c �b 0 a  
�a 
msng
�` 
pnam
�_ 
alis
�^ 
pcls
�] 
docu�\ �f A*j  Ec   O���&lv��lv�keb   �v�b   %�%lv�������a lv�vEc  � �[>�Z�Y���X�[ 80 test_literalrepresentation test_literalRepresentation�Z  �Y  � �W�V�U�W 0 aref aRef�V 0 avalue aValue�U  0 expectedresult expectedResult� �T�S�R�Q 	�P �O�N�M�L�K
�T 
kocl
�S 
cobj
�R .corecnte****       ****
�Q 
scpt
�P 
Valu
�O 
For_
�N .Txt:FLitnull��� ��� null
�M 
Equa�L 
�K .���:AsRenull��� ��� null�X J Hb  [��l kh  �E[�k/E�Z[�l/E�ZO)��/ *�)��/ 	*�l U�� U[OY��s �J\�I�H���G
�J .aevtoappnull  �   � ****�I  �H  �  � c�F�E�D�C
�F .earsffdralis        afdr
�E 
psxp
�D 
strq
�C .sysoexecTEXT���     TEXT�G �)j �,�,%j ascr  ��ޭ