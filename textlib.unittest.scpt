FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l     �� 	 
��   	
 Important: test scripts must *delegate* to TestLib, not `use` it. (The `do unit test` handler needs to receive the suite_NAME object as its direct parameter, when called from OSAKit/OpenScripting. Though actually getting this to work is another problem entirely...)    
 �     I m p o r t a n t :   t e s t   s c r i p t s   m u s t   * d e l e g a t e *   t o   T e s t L i b ,   n o t   ` u s e `   i t .   ( T h e   ` d o   u n i t   t e s t `   h a n d l e r   n e e d s   t o   r e c e i v e   t h e   s u i t e _ N A M E   o b j e c t   a s   i t s   d i r e c t   p a r a m e t e r ,   w h e n   c a l l e d   f r o m   O S A K i t / O p e n S c r i p t i n g .   T h o u g h   a c t u a l l y   g e t t i n g   t h i s   t o   w o r k   i s   a n o t h e r   p r o b l e m   e n t i r e l y . . . )      l     ��������  ��  ��        l          j     �� 
�� 
pare  N        4     �� 
�� 
scpt  m       �    T e s t L i b �� note: `property parent : ...` doesn't import terminology, so the tests themselves must be wrapped in `using terms from...` block in order to compile correctly (the alternative is to strip terminology from TestLib and use ObjC-style handler names, which are more amenable to 'optional' params by defining multiple variations of the same name, or else use `assertResult for PARAMS_RECORD` which allows optional params albeit with odd syntax)     �  p   n o t e :   ` p r o p e r t y   p a r e n t   :   . . . `   d o e s n ' t   i m p o r t   t e r m i n o l o g y ,   s o   t h e   t e s t s   t h e m s e l v e s   m u s t   b e   w r a p p e d   i n   ` u s i n g   t e r m s   f r o m . . . `   b l o c k   i n   o r d e r   t o   c o m p i l e   c o r r e c t l y   ( t h e   a l t e r n a t i v e   i s   t o   s t r i p   t e r m i n o l o g y   f r o m   T e s t L i b   a n d   u s e   O b j C - s t y l e   h a n d l e r   n a m e s ,   w h i c h   a r e   m o r e   a m e n a b l e   t o   ' o p t i o n a l '   p a r a m s   b y   d e f i n i n g   m u l t i p l e   v a r i a t i o n s   o f   t h e   s a m e   n a m e ,   o r   e l s e   u s e   ` a s s e r t R e s u l t   f o r   P A R A M S _ R E C O R D `   w h i c h   a l l o w s   o p t i o n a l   p a r a m s   a l b e i t   w i t h   o d d   s y n t a x )      l     ��������  ��  ��        l     ��������  ��  ��        l     ��   ��     use scripting additions      � ! ! . u s e   s c r i p t i n g   a d d i t i o n s   " # " l     ��������  ��  ��   #  $ % $ l      & ' ( & x   	 �� )����   ) 4     �� *
�� 
scpt * m     + + � , ,  T e x t L i b��   ' � � the script being tested (note: when testing non-library scripts, Standard Additions' `load script` should be used instead; eventually TestLib should provide convenience APIs to do this automatically)    ( � - -�   t h e   s c r i p t   b e i n g   t e s t e d   ( n o t e :   w h e n   t e s t i n g   n o n - l i b r a r y   s c r i p t s ,   S t a n d a r d   A d d i t i o n s '   ` l o a d   s c r i p t `   s h o u l d   b e   u s e d   i n s t e a d ;   e v e n t u a l l y   T e s t L i b   s h o u l d   p r o v i d e   c o n v e n i e n c e   A P I s   t o   d o   t h i s   a u t o m a t i c a l l y ) %  . / . l     ��������  ��  ��   /  0 1 0 l     ��������  ��  ��   1  2 3 2 w       4 5 4 k       6 6  7 8 7 l     ��������  ��  ��   8  9 : 9 h    �� ;�� $0 suite_modifytext suite_ModifyText ; k       < <  = > = l     ��������  ��  ��   >  ? @ ? i     A�� A I      �������� 0 setup setUp��  ��  ��   @  B C B l     ��������  ��  ��   C  D E D i    F�� F I      �������� 0 teardown tearDown��  ��  ��   E  G H G l     ��������  ��  ��   H  I J I l     �� K L��   K d ^ consider optional handler for determining if a given test should run, skip, or expect to fail    L � M M �   c o n s i d e r   o p t i o n a l   h a n d l e r   f o r   d e t e r m i n i n g   i f   a   g i v e n   t e s t   s h o u l d   r u n ,   s k i p ,   o r   e x p e c t   t o   f a i l J  N O N l     ��������  ��  ��   O  P Q P i    R S R I      �������� 0 test_uc1  ��  ��   S I    ���� T
�� .#@[:AsRenull��� ��� null��   T �� U V
�� 
Valu U l    W���� W I    X Y�� X z�� )
�� .Txt:UppTnull���     ctxt Y m   	 
 Z Z � [ [  f o � b � r��  ��  ��   V �� \��
�� 
Equa \ m     ] ] � ^ ^  F O � B � R��   Q  _ ` _ l     ��������  ��  ��   `  a b a i    c d c I      �������� 0 test_uc2  ��  ��   d X     / e�� f e I   *���� g
�� .#@[:AsErnull��� ��� null��   g �� h i
�� 
Hand h m     j j � k k  t r a p _ u c 2 i �� l m
�� 
Args l J    ! n n  o�� o n    p q p 1    ��
�� 
pcnt q o    ���� 0 aref aRef��   m �� r��
�� 
Equa r K   " & s s �� t���� 0 errornumber errorNumber t m   # $�����Y��  ��  �� 0 aref aRef f J     u u  v w v K     x x �� y���� 0 a   y m     z z � { {  f o o��   w  |�� | J    
 } }  ~�� ~ 1    ��
�� 
ascr��  ��   b   �  l     ��������  ��  ��   �  � � � i    � � � I      �� ����� 0 trap_uc2   �  ��� � o      ���� 0 directparam directParam��  ��   � l     � � � � I     � ��� � z�� )
�� .Txt:UppTnull���     ctxt � o    ���� 0 directparam directParam��   � X R important: trap_NAME handlers contain ONLY the command being tested; nothing else    � � � � �   i m p o r t a n t :   t r a p _ N A M E   h a n d l e r s   c o n t a i n   O N L Y   t h e   c o m m a n d   b e i n g   t e s t e d ;   n o t h i n g   e l s e �  � � � l     ��������  ��  ��   �  ��� � l     ��������  ��  ��  ��   :  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   �   DEBUG    � � � �    D E B U G �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   �tell suite_ModifyText to do unit test suite name "suite_ModifyText" handler name "test_uc1" all handler names {} with terminal styles -- TEST; dispatching `do unit test` from inside unittest script works fine; problem is how to do it from OSAKit/OpenScripting API    � � � � t e l l   s u i t e _ M o d i f y T e x t   t o   d o   u n i t   t e s t   s u i t e   n a m e   " s u i t e _ M o d i f y T e x t "   h a n d l e r   n a m e   " t e s t _ u c 1 "   a l l   h a n d l e r   n a m e s   { }   w i t h   t e r m i n a l   s t y l e s   - -   T E S T ;   d i s p a t c h i n g   ` d o   u n i t   t e s t `   f r o m   i n s i d e   u n i t t e s t   s c r i p t   w o r k s   f i n e ;   p r o b l e m   i s   h o w   t o   d o   i t   f r o m   O S A K i t / O p e n S c r i p t i n g   A P I �  � � � l      �� � ���   � # OK, , expected result, FO�B�R    � � � � : O K ,   ,   e x p e c t e d   r e s u l t ,   F O � B � R �  � � � l     �� � ���   � "  Result: �script TestReport�    � � � � 8   R e s u l t :   � s c r i p t   T e s t R e p o r t � �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  ��� � l     ����~��  �  �~  ��   5 4      �} �
�} 
scpt � m       � � � � �  T e s t L i b 3  � � � l     �|�{�z�|  �{  �z   �  � � � l     �y�x�w�y  �x  �w   �  � � � l     �v�u�t�v  �u  �t   �  � � � l     �s�r�q�s  �r  �q   �  ��p � l     �o�n�m�o  �n  �m  �p     � �   �l 
�l 
scpt  �k ��j � ��k   � �i�h�g
�i 
pare
�h 
pimr�g $0 suite_modifytext suite_ModifyText�j   � �f ��f  �   � � �e ��d
�e 
cobj �  � �   �c +
�c 
scpt�d   � �b ;   ��b $0 suite_modifytext suite_ModifyText � �a � � � � � ��a   � �`�_�^�]�\�` 0 setup setUp�_ 0 teardown tearDown�^ 0 test_uc1  �] 0 test_uc2  �\ 0 trap_uc2   � �[�Z�Y�X � ��W�[ 0 setup setUp�Z  �Y  �X   �   �  �W h � �V�U�T�S � ��R�V 0 teardown tearDown�U  �T  �S   �   �  �R h � �Q S�P�O � ��N�Q 0 test_uc1  �P  �O   �   � 	�M�L + Z�K�J ]�I�H
�M 
Valu
�L 
scpt
�K .Txt:UppTnull���     ctxt
�J 
Equa�I 
�H .#@[:AsRenull��� ��� null�N *�)��/ �j U���  � �G d�F�E � ��D�G 0 test_uc2  �F  �E   � �C�C 0 aref aRef � �B z�A�@�?�>�= j�<�;�:�9�8�7�6�B 0 a  
�A 
ascr
�@ 
kocl
�? 
cobj
�> .corecnte****       ****
�= 
Hand
�< 
Args
�; 
pcnt
�: 
Equa�9 0 errornumber errorNumber�8�Y�7 
�6 .#@[:AsErnull��� ��� null�D 0 .��l�kvlv[��l kh  *����,kv���l� [OY�� � �5 ��4�3 � ��2�5 0 trap_uc2  �4 �1 ��1  �  �0�0 0 directparam directParam�3   � �/�/ 0 directparam directParam � �. +�-
�. 
scpt
�- .Txt:UppTnull���     ctxt�2 )��/ �j U ascr  ��ޭ