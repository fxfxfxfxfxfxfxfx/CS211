
../riscv-elf/test_float_asmMOP.riscv:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	3f8000ef          	jal	104f4 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11ee0 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	620000ef          	jal	10734 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	61c50513          	add	a0,a0,1564 # 1061c <__libc_fini_array>
   10128:	5500006f          	j	10678 <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00002197          	auipc	gp,0x2
   10134:	e6818193          	add	gp,gp,-408 # 11f98 <__global_pointer$>
   10138:	f6018513          	add	a0,gp,-160 # 11ef8 <completed.1>
   1013c:	f9818613          	add	a2,gp,-104 # 11f30 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	2d0000ef          	jal	10418 <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	52c50513          	add	a0,a0,1324 # 10678 <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	4c450513          	add	a0,a0,1220 # 1061c <__libc_fini_array>
   10160:	518000ef          	jal	10678 <atexit>
   10164:	218000ef          	jal	1037c <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	add	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	06c000ef          	jal	101e0 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	add	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11ef8 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	77850513          	add	a0,a0,1912 # 11778 <__EH_FRAME_BEGIN__>
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11ef8 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	add	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	f6818593          	add	a1,gp,-152 # 11f00 <object.0>
   101d0:	77850513          	add	a0,a0,1912 # 11778 <__EH_FRAME_BEGIN__>
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <main>:
   101e0:	fe010113          	add	sp,sp,-32
   101e4:	00113c23          	sd	ra,24(sp)
   101e8:	00813823          	sd	s0,16(sp)
   101ec:	02010413          	add	s0,sp,32
   101f0:	000107b7          	lui	a5,0x10
   101f4:	76c7a787          	flw	fa5,1900(a5) # 1076c <__errno+0x8>
   101f8:	fef42627          	fsw	fa5,-20(s0)
   101fc:	000107b7          	lui	a5,0x10
   10200:	7707a787          	flw	fa5,1904(a5) # 10770 <__errno+0xc>
   10204:	fef42427          	fsw	fa5,-24(s0)
   10208:	000107b7          	lui	a5,0x10
   1020c:	7747a787          	flw	fa5,1908(a5) # 10774 <__errno+0x10>
   10210:	fef42227          	fsw	fa5,-28(s0)
   10214:	fec42787          	flw	fa5,-20(s0)
   10218:	fe842707          	flw	fa4,-24(s0)
   1021c:	fe442687          	flw	fa3,-28(s0)
   10220:	68e7f7c3          	fmadd.s	fa5,fa5,fa4,fa3
   10224:	fef42027          	fsw	fa5,-32(s0)
   10228:	fe042507          	flw	fa0,-32(s0)
   1022c:	128000ef          	jal	10354 <print_f>
   10230:	00a00513          	li	a0,10
   10234:	070000ef          	jal	102a4 <print_c>
   10238:	00000793          	li	a5,0
   1023c:	00078513          	mv	a0,a5
   10240:	01813083          	ld	ra,24(sp)
   10244:	01013403          	ld	s0,16(sp)
   10248:	02010113          	add	sp,sp,32
   1024c:	00008067          	ret

0000000000010250 <print_d>:
   10250:	fe010113          	add	sp,sp,-32
   10254:	00813c23          	sd	s0,24(sp)
   10258:	02010413          	add	s0,sp,32
   1025c:	00050793          	mv	a5,a0
   10260:	fef42623          	sw	a5,-20(s0)
   10264:	00200893          	li	a7,2
   10268:	00000073          	ecall
   1026c:	00000013          	nop
   10270:	01813403          	ld	s0,24(sp)
   10274:	02010113          	add	sp,sp,32
   10278:	00008067          	ret

000000000001027c <print_s>:
   1027c:	fe010113          	add	sp,sp,-32
   10280:	00813c23          	sd	s0,24(sp)
   10284:	02010413          	add	s0,sp,32
   10288:	fea43423          	sd	a0,-24(s0)
   1028c:	00000893          	li	a7,0
   10290:	00000073          	ecall
   10294:	00000013          	nop
   10298:	01813403          	ld	s0,24(sp)
   1029c:	02010113          	add	sp,sp,32
   102a0:	00008067          	ret

00000000000102a4 <print_c>:
   102a4:	fe010113          	add	sp,sp,-32
   102a8:	00813c23          	sd	s0,24(sp)
   102ac:	02010413          	add	s0,sp,32
   102b0:	00050793          	mv	a5,a0
   102b4:	fef407a3          	sb	a5,-17(s0)
   102b8:	00100893          	li	a7,1
   102bc:	00000073          	ecall
   102c0:	00000013          	nop
   102c4:	01813403          	ld	s0,24(sp)
   102c8:	02010113          	add	sp,sp,32
   102cc:	00008067          	ret

00000000000102d0 <exit_proc>:
   102d0:	ff010113          	add	sp,sp,-16
   102d4:	00813423          	sd	s0,8(sp)
   102d8:	01010413          	add	s0,sp,16
   102dc:	00300893          	li	a7,3
   102e0:	00000073          	ecall
   102e4:	00000013          	nop
   102e8:	00813403          	ld	s0,8(sp)
   102ec:	01010113          	add	sp,sp,16
   102f0:	00008067          	ret

00000000000102f4 <read_char>:
   102f4:	fe010113          	add	sp,sp,-32
   102f8:	00813c23          	sd	s0,24(sp)
   102fc:	02010413          	add	s0,sp,32
   10300:	00400893          	li	a7,4
   10304:	00000073          	ecall
   10308:	00050793          	mv	a5,a0
   1030c:	fef407a3          	sb	a5,-17(s0)
   10310:	fef44783          	lbu	a5,-17(s0)
   10314:	00078513          	mv	a0,a5
   10318:	01813403          	ld	s0,24(sp)
   1031c:	02010113          	add	sp,sp,32
   10320:	00008067          	ret

0000000000010324 <read_num>:
   10324:	fe010113          	add	sp,sp,-32
   10328:	00813c23          	sd	s0,24(sp)
   1032c:	02010413          	add	s0,sp,32
   10330:	00500893          	li	a7,5
   10334:	00000073          	ecall
   10338:	00050793          	mv	a5,a0
   1033c:	fef43423          	sd	a5,-24(s0)
   10340:	fe843783          	ld	a5,-24(s0)
   10344:	00078513          	mv	a0,a5
   10348:	01813403          	ld	s0,24(sp)
   1034c:	02010113          	add	sp,sp,32
   10350:	00008067          	ret

0000000000010354 <print_f>:
   10354:	fe010113          	add	sp,sp,-32
   10358:	00813c23          	sd	s0,24(sp)
   1035c:	02010413          	add	s0,sp,32
   10360:	fea42627          	fsw	fa0,-20(s0)
   10364:	00600893          	li	a7,6
   10368:	00000073          	ecall
   1036c:	00000013          	nop
   10370:	01813403          	ld	s0,24(sp)
   10374:	02010113          	add	sp,sp,32
   10378:	00008067          	ret

000000000001037c <__libc_init_array>:
   1037c:	fe010113          	add	sp,sp,-32
   10380:	00813823          	sd	s0,16(sp)
   10384:	000117b7          	lui	a5,0x11
   10388:	00011437          	lui	s0,0x11
   1038c:	01213023          	sd	s2,0(sp)
   10390:	77c78793          	add	a5,a5,1916 # 1177c <__preinit_array_end>
   10394:	77c40713          	add	a4,s0,1916 # 1177c <__preinit_array_end>
   10398:	00113c23          	sd	ra,24(sp)
   1039c:	00913423          	sd	s1,8(sp)
   103a0:	40e78933          	sub	s2,a5,a4
   103a4:	02e78263          	beq	a5,a4,103c8 <__libc_init_array+0x4c>
   103a8:	40395913          	sra	s2,s2,0x3
   103ac:	77c40413          	add	s0,s0,1916
   103b0:	00000493          	li	s1,0
   103b4:	00043783          	ld	a5,0(s0)
   103b8:	00148493          	add	s1,s1,1
   103bc:	00840413          	add	s0,s0,8
   103c0:	000780e7          	jalr	a5
   103c4:	ff24e8e3          	bltu	s1,s2,103b4 <__libc_init_array+0x38>
   103c8:	00011437          	lui	s0,0x11
   103cc:	000117b7          	lui	a5,0x11
   103d0:	79078793          	add	a5,a5,1936 # 11790 <__do_global_dtors_aux_fini_array_entry>
   103d4:	78040713          	add	a4,s0,1920 # 11780 <__init_array_start>
   103d8:	40e78933          	sub	s2,a5,a4
   103dc:	40395913          	sra	s2,s2,0x3
   103e0:	02e78063          	beq	a5,a4,10400 <__libc_init_array+0x84>
   103e4:	78040413          	add	s0,s0,1920
   103e8:	00000493          	li	s1,0
   103ec:	00043783          	ld	a5,0(s0)
   103f0:	00148493          	add	s1,s1,1
   103f4:	00840413          	add	s0,s0,8
   103f8:	000780e7          	jalr	a5
   103fc:	ff24e8e3          	bltu	s1,s2,103ec <__libc_init_array+0x70>
   10400:	01813083          	ld	ra,24(sp)
   10404:	01013403          	ld	s0,16(sp)
   10408:	00813483          	ld	s1,8(sp)
   1040c:	00013903          	ld	s2,0(sp)
   10410:	02010113          	add	sp,sp,32
   10414:	00008067          	ret

0000000000010418 <memset>:
   10418:	00f00313          	li	t1,15
   1041c:	00050713          	mv	a4,a0
   10420:	02c37a63          	bgeu	t1,a2,10454 <memset+0x3c>
   10424:	00f77793          	and	a5,a4,15
   10428:	0a079063          	bnez	a5,104c8 <memset+0xb0>
   1042c:	06059e63          	bnez	a1,104a8 <memset+0x90>
   10430:	ff067693          	and	a3,a2,-16
   10434:	00f67613          	and	a2,a2,15
   10438:	00e686b3          	add	a3,a3,a4
   1043c:	00b73023          	sd	a1,0(a4)
   10440:	00b73423          	sd	a1,8(a4)
   10444:	01070713          	add	a4,a4,16
   10448:	fed76ae3          	bltu	a4,a3,1043c <memset+0x24>
   1044c:	00061463          	bnez	a2,10454 <memset+0x3c>
   10450:	00008067          	ret
   10454:	40c306b3          	sub	a3,t1,a2
   10458:	00269693          	sll	a3,a3,0x2
   1045c:	00000297          	auipc	t0,0x0
   10460:	005686b3          	add	a3,a3,t0
   10464:	00c68067          	jr	12(a3)
   10468:	00b70723          	sb	a1,14(a4)
   1046c:	00b706a3          	sb	a1,13(a4)
   10470:	00b70623          	sb	a1,12(a4)
   10474:	00b705a3          	sb	a1,11(a4)
   10478:	00b70523          	sb	a1,10(a4)
   1047c:	00b704a3          	sb	a1,9(a4)
   10480:	00b70423          	sb	a1,8(a4)
   10484:	00b703a3          	sb	a1,7(a4)
   10488:	00b70323          	sb	a1,6(a4)
   1048c:	00b702a3          	sb	a1,5(a4)
   10490:	00b70223          	sb	a1,4(a4)
   10494:	00b701a3          	sb	a1,3(a4)
   10498:	00b70123          	sb	a1,2(a4)
   1049c:	00b700a3          	sb	a1,1(a4)
   104a0:	00b70023          	sb	a1,0(a4)
   104a4:	00008067          	ret
   104a8:	0ff5f593          	zext.b	a1,a1
   104ac:	00859693          	sll	a3,a1,0x8
   104b0:	00d5e5b3          	or	a1,a1,a3
   104b4:	01059693          	sll	a3,a1,0x10
   104b8:	00d5e5b3          	or	a1,a1,a3
   104bc:	02059693          	sll	a3,a1,0x20
   104c0:	00d5e5b3          	or	a1,a1,a3
   104c4:	f6dff06f          	j	10430 <memset+0x18>
   104c8:	00279693          	sll	a3,a5,0x2
   104cc:	00000297          	auipc	t0,0x0
   104d0:	005686b3          	add	a3,a3,t0
   104d4:	00008293          	mv	t0,ra
   104d8:	f98680e7          	jalr	-104(a3)
   104dc:	00028093          	mv	ra,t0
   104e0:	ff078793          	add	a5,a5,-16
   104e4:	40f70733          	sub	a4,a4,a5
   104e8:	00f60633          	add	a2,a2,a5
   104ec:	f6c374e3          	bgeu	t1,a2,10454 <memset+0x3c>
   104f0:	f3dff06f          	j	1042c <memset+0x14>

00000000000104f4 <__call_exitprocs>:
   104f4:	fb010113          	add	sp,sp,-80
   104f8:	03413023          	sd	s4,32(sp)
   104fc:	f481ba03          	ld	s4,-184(gp) # 11ee0 <_global_impure_ptr>
   10500:	03213823          	sd	s2,48(sp)
   10504:	04113423          	sd	ra,72(sp)
   10508:	1f8a3903          	ld	s2,504(s4)
   1050c:	04813023          	sd	s0,64(sp)
   10510:	02913c23          	sd	s1,56(sp)
   10514:	03313423          	sd	s3,40(sp)
   10518:	01513c23          	sd	s5,24(sp)
   1051c:	01613823          	sd	s6,16(sp)
   10520:	01713423          	sd	s7,8(sp)
   10524:	01813023          	sd	s8,0(sp)
   10528:	04090063          	beqz	s2,10568 <__call_exitprocs+0x74>
   1052c:	00050b13          	mv	s6,a0
   10530:	00058b93          	mv	s7,a1
   10534:	00100a93          	li	s5,1
   10538:	fff00993          	li	s3,-1
   1053c:	00892483          	lw	s1,8(s2)
   10540:	fff4841b          	addw	s0,s1,-1
   10544:	02044263          	bltz	s0,10568 <__call_exitprocs+0x74>
   10548:	00349493          	sll	s1,s1,0x3
   1054c:	009904b3          	add	s1,s2,s1
   10550:	040b8463          	beqz	s7,10598 <__call_exitprocs+0xa4>
   10554:	2084b783          	ld	a5,520(s1)
   10558:	05778063          	beq	a5,s7,10598 <__call_exitprocs+0xa4>
   1055c:	fff4041b          	addw	s0,s0,-1
   10560:	ff848493          	add	s1,s1,-8
   10564:	ff3416e3          	bne	s0,s3,10550 <__call_exitprocs+0x5c>
   10568:	04813083          	ld	ra,72(sp)
   1056c:	04013403          	ld	s0,64(sp)
   10570:	03813483          	ld	s1,56(sp)
   10574:	03013903          	ld	s2,48(sp)
   10578:	02813983          	ld	s3,40(sp)
   1057c:	02013a03          	ld	s4,32(sp)
   10580:	01813a83          	ld	s5,24(sp)
   10584:	01013b03          	ld	s6,16(sp)
   10588:	00813b83          	ld	s7,8(sp)
   1058c:	00013c03          	ld	s8,0(sp)
   10590:	05010113          	add	sp,sp,80
   10594:	00008067          	ret
   10598:	00892783          	lw	a5,8(s2)
   1059c:	0084b703          	ld	a4,8(s1)
   105a0:	fff7879b          	addw	a5,a5,-1
   105a4:	06878263          	beq	a5,s0,10608 <__call_exitprocs+0x114>
   105a8:	0004b423          	sd	zero,8(s1)
   105ac:	fa0708e3          	beqz	a4,1055c <__call_exitprocs+0x68>
   105b0:	31092783          	lw	a5,784(s2)
   105b4:	008a96bb          	sllw	a3,s5,s0
   105b8:	00892c03          	lw	s8,8(s2)
   105bc:	00d7f7b3          	and	a5,a5,a3
   105c0:	0007879b          	sext.w	a5,a5
   105c4:	02079263          	bnez	a5,105e8 <__call_exitprocs+0xf4>
   105c8:	000700e7          	jalr	a4
   105cc:	00892703          	lw	a4,8(s2)
   105d0:	1f8a3783          	ld	a5,504(s4)
   105d4:	01871463          	bne	a4,s8,105dc <__call_exitprocs+0xe8>
   105d8:	f92782e3          	beq	a5,s2,1055c <__call_exitprocs+0x68>
   105dc:	f80786e3          	beqz	a5,10568 <__call_exitprocs+0x74>
   105e0:	00078913          	mv	s2,a5
   105e4:	f59ff06f          	j	1053c <__call_exitprocs+0x48>
   105e8:	31492783          	lw	a5,788(s2)
   105ec:	1084b583          	ld	a1,264(s1)
   105f0:	00d7f7b3          	and	a5,a5,a3
   105f4:	0007879b          	sext.w	a5,a5
   105f8:	00079c63          	bnez	a5,10610 <__call_exitprocs+0x11c>
   105fc:	000b0513          	mv	a0,s6
   10600:	000700e7          	jalr	a4
   10604:	fc9ff06f          	j	105cc <__call_exitprocs+0xd8>
   10608:	00892423          	sw	s0,8(s2)
   1060c:	fa1ff06f          	j	105ac <__call_exitprocs+0xb8>
   10610:	00058513          	mv	a0,a1
   10614:	000700e7          	jalr	a4
   10618:	fb5ff06f          	j	105cc <__call_exitprocs+0xd8>

000000000001061c <__libc_fini_array>:
   1061c:	fe010113          	add	sp,sp,-32
   10620:	00813823          	sd	s0,16(sp)
   10624:	000117b7          	lui	a5,0x11
   10628:	00011437          	lui	s0,0x11
   1062c:	79078793          	add	a5,a5,1936 # 11790 <__do_global_dtors_aux_fini_array_entry>
   10630:	79840413          	add	s0,s0,1944 # 11798 <impure_data>
   10634:	40f40433          	sub	s0,s0,a5
   10638:	00913423          	sd	s1,8(sp)
   1063c:	00113c23          	sd	ra,24(sp)
   10640:	40345493          	sra	s1,s0,0x3
   10644:	02048063          	beqz	s1,10664 <__libc_fini_array+0x48>
   10648:	ff840413          	add	s0,s0,-8
   1064c:	00f40433          	add	s0,s0,a5
   10650:	00043783          	ld	a5,0(s0)
   10654:	fff48493          	add	s1,s1,-1
   10658:	ff840413          	add	s0,s0,-8
   1065c:	000780e7          	jalr	a5
   10660:	fe0498e3          	bnez	s1,10650 <__libc_fini_array+0x34>
   10664:	01813083          	ld	ra,24(sp)
   10668:	01013403          	ld	s0,16(sp)
   1066c:	00813483          	ld	s1,8(sp)
   10670:	02010113          	add	sp,sp,32
   10674:	00008067          	ret

0000000000010678 <atexit>:
   10678:	00050593          	mv	a1,a0
   1067c:	00000693          	li	a3,0
   10680:	00000613          	li	a2,0
   10684:	00000513          	li	a0,0
   10688:	0040006f          	j	1068c <__register_exitproc>

000000000001068c <__register_exitproc>:
   1068c:	f481b703          	ld	a4,-184(gp) # 11ee0 <_global_impure_ptr>
   10690:	1f873783          	ld	a5,504(a4)
   10694:	06078063          	beqz	a5,106f4 <__register_exitproc+0x68>
   10698:	0087a703          	lw	a4,8(a5)
   1069c:	01f00813          	li	a6,31
   106a0:	08e84663          	blt	a6,a4,1072c <__register_exitproc+0xa0>
   106a4:	02050863          	beqz	a0,106d4 <__register_exitproc+0x48>
   106a8:	00371813          	sll	a6,a4,0x3
   106ac:	01078833          	add	a6,a5,a6
   106b0:	10c83823          	sd	a2,272(a6)
   106b4:	3107a883          	lw	a7,784(a5)
   106b8:	00100613          	li	a2,1
   106bc:	00e6163b          	sllw	a2,a2,a4
   106c0:	00c8e8b3          	or	a7,a7,a2
   106c4:	3117a823          	sw	a7,784(a5)
   106c8:	20d83823          	sd	a3,528(a6)
   106cc:	00200693          	li	a3,2
   106d0:	02d50863          	beq	a0,a3,10700 <__register_exitproc+0x74>
   106d4:	00270693          	add	a3,a4,2
   106d8:	00369693          	sll	a3,a3,0x3
   106dc:	0017071b          	addw	a4,a4,1
   106e0:	00e7a423          	sw	a4,8(a5)
   106e4:	00d787b3          	add	a5,a5,a3
   106e8:	00b7b023          	sd	a1,0(a5)
   106ec:	00000513          	li	a0,0
   106f0:	00008067          	ret
   106f4:	20070793          	add	a5,a4,512
   106f8:	1ef73c23          	sd	a5,504(a4)
   106fc:	f9dff06f          	j	10698 <__register_exitproc+0xc>
   10700:	3147a683          	lw	a3,788(a5)
   10704:	00000513          	li	a0,0
   10708:	00c6e6b3          	or	a3,a3,a2
   1070c:	30d7aa23          	sw	a3,788(a5)
   10710:	00270693          	add	a3,a4,2
   10714:	00369693          	sll	a3,a3,0x3
   10718:	0017071b          	addw	a4,a4,1
   1071c:	00e7a423          	sw	a4,8(a5)
   10720:	00d787b3          	add	a5,a5,a3
   10724:	00b7b023          	sd	a1,0(a5)
   10728:	00008067          	ret
   1072c:	fff00513          	li	a0,-1
   10730:	00008067          	ret

0000000000010734 <_exit>:
   10734:	05d00893          	li	a7,93
   10738:	00000073          	ecall
   1073c:	00054463          	bltz	a0,10744 <_exit+0x10>
   10740:	0000006f          	j	10740 <_exit+0xc>
   10744:	ff010113          	add	sp,sp,-16
   10748:	00813023          	sd	s0,0(sp)
   1074c:	00050413          	mv	s0,a0
   10750:	00113423          	sd	ra,8(sp)
   10754:	4080043b          	negw	s0,s0
   10758:	00c000ef          	jal	10764 <__errno>
   1075c:	00852023          	sw	s0,0(a0)
   10760:	0000006f          	j	10760 <_exit+0x2c>

0000000000010764 <__errno>:
   10764:	f581b503          	ld	a0,-168(gp) # 11ef0 <_impure_ptr>
   10768:	00008067          	ret
