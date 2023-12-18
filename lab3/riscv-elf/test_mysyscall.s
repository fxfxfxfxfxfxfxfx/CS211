
../riscv-elf/test_mysyscall.riscv:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	4b0000ef          	jal	105ac <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11768 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	6d8000ef          	jal	107ec <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	6d450513          	add	a0,a0,1748 # 106d4 <__libc_fini_array>
   10128:	6080006f          	j	10730 <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00001197          	auipc	gp,0x1
   10134:	6f018193          	add	gp,gp,1776 # 11820 <__global_pointer$>
   10138:	f6018513          	add	a0,gp,-160 # 11780 <completed.1>
   1013c:	f9818613          	add	a2,gp,-104 # 117b8 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	388000ef          	jal	104d0 <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	5e450513          	add	a0,a0,1508 # 10730 <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	57c50513          	add	a0,a0,1404 # 106d4 <__libc_fini_array>
   10160:	5d0000ef          	jal	10730 <atexit>
   10164:	2d0000ef          	jal	10434 <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	add	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	06c000ef          	jal	101e0 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	add	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11780 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	00050513          	mv	a0,a0
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11780 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	add	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	f6818593          	add	a1,gp,-152 # 11788 <object.0>
   101d0:	00050513          	mv	a0,a0
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <main>:
   101e0:	f9010113          	add	sp,sp,-112
   101e4:	06113423          	sd	ra,104(sp)
   101e8:	06813023          	sd	s0,96(sp)
   101ec:	07010413          	add	s0,sp,112
   101f0:	00b00793          	li	a5,11
   101f4:	fef42623          	sw	a5,-20(s0)
   101f8:	000117b7          	lui	a5,0x11
   101fc:	82878793          	add	a5,a5,-2008 # 10828 <__errno+0xc>
   10200:	0007b503          	ld	a0,0(a5)
   10204:	0087b583          	ld	a1,8(a5)
   10208:	0107b603          	ld	a2,16(a5)
   1020c:	0187b683          	ld	a3,24(a5)
   10210:	0207b703          	ld	a4,32(a5)
   10214:	fca43023          	sd	a0,-64(s0)
   10218:	fcb43423          	sd	a1,-56(s0)
   1021c:	fcc43823          	sd	a2,-48(s0)
   10220:	fcd43c23          	sd	a3,-40(s0)
   10224:	fee43023          	sd	a4,-32(s0)
   10228:	0287a783          	lw	a5,40(a5)
   1022c:	fef42423          	sw	a5,-24(s0)
   10230:	f9040693          	add	a3,s0,-112
   10234:	fc040713          	add	a4,s0,-64
   10238:	fec42783          	lw	a5,-20(s0)
   1023c:	00068613          	mv	a2,a3
   10240:	00070593          	mv	a1,a4
   10244:	00078513          	mv	a0,a5
   10248:	17c000ef          	jal	103c4 <set_array>
   1024c:	f9040713          	add	a4,s0,-112
   10250:	fec42783          	lw	a5,-20(s0)
   10254:	00070593          	mv	a1,a4
   10258:	00078513          	mv	a0,a5
   1025c:	19c000ef          	jal	103f8 <get_arraymax>
   10260:	00050793          	mv	a5,a0
   10264:	fef42623          	sw	a5,-20(s0)
   10268:	fec42783          	lw	a5,-20(s0)
   1026c:	00078513          	mv	a0,a5
   10270:	028000ef          	jal	10298 <print_d>
   10274:	00a00513          	li	a0,10
   10278:	074000ef          	jal	102ec <print_c>
   1027c:	09c000ef          	jal	10318 <exit_proc>
   10280:	00000793          	li	a5,0
   10284:	00078513          	mv	a0,a5
   10288:	06813083          	ld	ra,104(sp)
   1028c:	06013403          	ld	s0,96(sp)
   10290:	07010113          	add	sp,sp,112
   10294:	00008067          	ret

0000000000010298 <print_d>:
   10298:	fe010113          	add	sp,sp,-32
   1029c:	00813c23          	sd	s0,24(sp)
   102a0:	02010413          	add	s0,sp,32
   102a4:	00050793          	mv	a5,a0
   102a8:	fef42623          	sw	a5,-20(s0)
   102ac:	00200893          	li	a7,2
   102b0:	00000073          	ecall
   102b4:	00000013          	nop
   102b8:	01813403          	ld	s0,24(sp)
   102bc:	02010113          	add	sp,sp,32
   102c0:	00008067          	ret

00000000000102c4 <print_s>:
   102c4:	fe010113          	add	sp,sp,-32
   102c8:	00813c23          	sd	s0,24(sp)
   102cc:	02010413          	add	s0,sp,32
   102d0:	fea43423          	sd	a0,-24(s0)
   102d4:	00000893          	li	a7,0
   102d8:	00000073          	ecall
   102dc:	00000013          	nop
   102e0:	01813403          	ld	s0,24(sp)
   102e4:	02010113          	add	sp,sp,32
   102e8:	00008067          	ret

00000000000102ec <print_c>:
   102ec:	fe010113          	add	sp,sp,-32
   102f0:	00813c23          	sd	s0,24(sp)
   102f4:	02010413          	add	s0,sp,32
   102f8:	00050793          	mv	a5,a0
   102fc:	fef407a3          	sb	a5,-17(s0)
   10300:	00100893          	li	a7,1
   10304:	00000073          	ecall
   10308:	00000013          	nop
   1030c:	01813403          	ld	s0,24(sp)
   10310:	02010113          	add	sp,sp,32
   10314:	00008067          	ret

0000000000010318 <exit_proc>:
   10318:	ff010113          	add	sp,sp,-16
   1031c:	00813423          	sd	s0,8(sp)
   10320:	01010413          	add	s0,sp,16
   10324:	00300893          	li	a7,3
   10328:	00000073          	ecall
   1032c:	00000013          	nop
   10330:	00813403          	ld	s0,8(sp)
   10334:	01010113          	add	sp,sp,16
   10338:	00008067          	ret

000000000001033c <read_char>:
   1033c:	fe010113          	add	sp,sp,-32
   10340:	00813c23          	sd	s0,24(sp)
   10344:	02010413          	add	s0,sp,32
   10348:	00400893          	li	a7,4
   1034c:	00000073          	ecall
   10350:	00050793          	mv	a5,a0
   10354:	fef407a3          	sb	a5,-17(s0)
   10358:	fef44783          	lbu	a5,-17(s0)
   1035c:	00078513          	mv	a0,a5
   10360:	01813403          	ld	s0,24(sp)
   10364:	02010113          	add	sp,sp,32
   10368:	00008067          	ret

000000000001036c <read_num>:
   1036c:	fe010113          	add	sp,sp,-32
   10370:	00813c23          	sd	s0,24(sp)
   10374:	02010413          	add	s0,sp,32
   10378:	00500893          	li	a7,5
   1037c:	00000073          	ecall
   10380:	00050793          	mv	a5,a0
   10384:	fef43423          	sd	a5,-24(s0)
   10388:	fe843783          	ld	a5,-24(s0)
   1038c:	00078513          	mv	a0,a5
   10390:	01813403          	ld	s0,24(sp)
   10394:	02010113          	add	sp,sp,32
   10398:	00008067          	ret

000000000001039c <print_f>:
   1039c:	fe010113          	add	sp,sp,-32
   103a0:	00813c23          	sd	s0,24(sp)
   103a4:	02010413          	add	s0,sp,32
   103a8:	fea42627          	fsw	fa0,-20(s0)
   103ac:	00600893          	li	a7,6
   103b0:	00000073          	ecall
   103b4:	00000013          	nop
   103b8:	01813403          	ld	s0,24(sp)
   103bc:	02010113          	add	sp,sp,32
   103c0:	00008067          	ret

00000000000103c4 <set_array>:
   103c4:	fd010113          	add	sp,sp,-48
   103c8:	02813423          	sd	s0,40(sp)
   103cc:	03010413          	add	s0,sp,48
   103d0:	00050793          	mv	a5,a0
   103d4:	feb43023          	sd	a1,-32(s0)
   103d8:	fcc43c23          	sd	a2,-40(s0)
   103dc:	fef42623          	sw	a5,-20(s0)
   103e0:	00700893          	li	a7,7
   103e4:	00000073          	ecall
   103e8:	00000013          	nop
   103ec:	02813403          	ld	s0,40(sp)
   103f0:	03010113          	add	sp,sp,48
   103f4:	00008067          	ret

00000000000103f8 <get_arraymax>:
   103f8:	fd010113          	add	sp,sp,-48
   103fc:	02813423          	sd	s0,40(sp)
   10400:	03010413          	add	s0,sp,48
   10404:	00050793          	mv	a5,a0
   10408:	fcb43823          	sd	a1,-48(s0)
   1040c:	fcf42e23          	sw	a5,-36(s0)
   10410:	00800893          	li	a7,8
   10414:	00000073          	ecall
   10418:	00050793          	mv	a5,a0
   1041c:	fef42623          	sw	a5,-20(s0)
   10420:	00000013          	nop
   10424:	00078513          	mv	a0,a5
   10428:	02813403          	ld	s0,40(sp)
   1042c:	03010113          	add	sp,sp,48
   10430:	00008067          	ret

0000000000010434 <__libc_init_array>:
   10434:	fe010113          	add	sp,sp,-32
   10438:	00813823          	sd	s0,16(sp)
   1043c:	000117b7          	lui	a5,0x11
   10440:	00011437          	lui	s0,0x11
   10444:	01213023          	sd	s2,0(sp)
   10448:	00478793          	add	a5,a5,4 # 11004 <__preinit_array_end>
   1044c:	00440713          	add	a4,s0,4 # 11004 <__preinit_array_end>
   10450:	00113c23          	sd	ra,24(sp)
   10454:	00913423          	sd	s1,8(sp)
   10458:	40e78933          	sub	s2,a5,a4
   1045c:	02e78263          	beq	a5,a4,10480 <__libc_init_array+0x4c>
   10460:	40395913          	sra	s2,s2,0x3
   10464:	00440413          	add	s0,s0,4
   10468:	00000493          	li	s1,0
   1046c:	00043783          	ld	a5,0(s0)
   10470:	00148493          	add	s1,s1,1
   10474:	00840413          	add	s0,s0,8
   10478:	000780e7          	jalr	a5
   1047c:	ff24e8e3          	bltu	s1,s2,1046c <__libc_init_array+0x38>
   10480:	00011437          	lui	s0,0x11
   10484:	000117b7          	lui	a5,0x11
   10488:	01878793          	add	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   1048c:	00840713          	add	a4,s0,8 # 11008 <__init_array_start>
   10490:	40e78933          	sub	s2,a5,a4
   10494:	40395913          	sra	s2,s2,0x3
   10498:	02e78063          	beq	a5,a4,104b8 <__libc_init_array+0x84>
   1049c:	00840413          	add	s0,s0,8
   104a0:	00000493          	li	s1,0
   104a4:	00043783          	ld	a5,0(s0)
   104a8:	00148493          	add	s1,s1,1
   104ac:	00840413          	add	s0,s0,8
   104b0:	000780e7          	jalr	a5
   104b4:	ff24e8e3          	bltu	s1,s2,104a4 <__libc_init_array+0x70>
   104b8:	01813083          	ld	ra,24(sp)
   104bc:	01013403          	ld	s0,16(sp)
   104c0:	00813483          	ld	s1,8(sp)
   104c4:	00013903          	ld	s2,0(sp)
   104c8:	02010113          	add	sp,sp,32
   104cc:	00008067          	ret

00000000000104d0 <memset>:
   104d0:	00f00313          	li	t1,15
   104d4:	00050713          	mv	a4,a0
   104d8:	02c37a63          	bgeu	t1,a2,1050c <memset+0x3c>
   104dc:	00f77793          	and	a5,a4,15
   104e0:	0a079063          	bnez	a5,10580 <memset+0xb0>
   104e4:	06059e63          	bnez	a1,10560 <memset+0x90>
   104e8:	ff067693          	and	a3,a2,-16
   104ec:	00f67613          	and	a2,a2,15
   104f0:	00e686b3          	add	a3,a3,a4
   104f4:	00b73023          	sd	a1,0(a4)
   104f8:	00b73423          	sd	a1,8(a4)
   104fc:	01070713          	add	a4,a4,16
   10500:	fed76ae3          	bltu	a4,a3,104f4 <memset+0x24>
   10504:	00061463          	bnez	a2,1050c <memset+0x3c>
   10508:	00008067          	ret
   1050c:	40c306b3          	sub	a3,t1,a2
   10510:	00269693          	sll	a3,a3,0x2
   10514:	00000297          	auipc	t0,0x0
   10518:	005686b3          	add	a3,a3,t0
   1051c:	00c68067          	jr	12(a3)
   10520:	00b70723          	sb	a1,14(a4)
   10524:	00b706a3          	sb	a1,13(a4)
   10528:	00b70623          	sb	a1,12(a4)
   1052c:	00b705a3          	sb	a1,11(a4)
   10530:	00b70523          	sb	a1,10(a4)
   10534:	00b704a3          	sb	a1,9(a4)
   10538:	00b70423          	sb	a1,8(a4)
   1053c:	00b703a3          	sb	a1,7(a4)
   10540:	00b70323          	sb	a1,6(a4)
   10544:	00b702a3          	sb	a1,5(a4)
   10548:	00b70223          	sb	a1,4(a4)
   1054c:	00b701a3          	sb	a1,3(a4)
   10550:	00b70123          	sb	a1,2(a4)
   10554:	00b700a3          	sb	a1,1(a4)
   10558:	00b70023          	sb	a1,0(a4)
   1055c:	00008067          	ret
   10560:	0ff5f593          	zext.b	a1,a1
   10564:	00859693          	sll	a3,a1,0x8
   10568:	00d5e5b3          	or	a1,a1,a3
   1056c:	01059693          	sll	a3,a1,0x10
   10570:	00d5e5b3          	or	a1,a1,a3
   10574:	02059693          	sll	a3,a1,0x20
   10578:	00d5e5b3          	or	a1,a1,a3
   1057c:	f6dff06f          	j	104e8 <memset+0x18>
   10580:	00279693          	sll	a3,a5,0x2
   10584:	00000297          	auipc	t0,0x0
   10588:	005686b3          	add	a3,a3,t0
   1058c:	00008293          	mv	t0,ra
   10590:	f98680e7          	jalr	-104(a3)
   10594:	00028093          	mv	ra,t0
   10598:	ff078793          	add	a5,a5,-16
   1059c:	40f70733          	sub	a4,a4,a5
   105a0:	00f60633          	add	a2,a2,a5
   105a4:	f6c374e3          	bgeu	t1,a2,1050c <memset+0x3c>
   105a8:	f3dff06f          	j	104e4 <memset+0x14>

00000000000105ac <__call_exitprocs>:
   105ac:	fb010113          	add	sp,sp,-80
   105b0:	03413023          	sd	s4,32(sp)
   105b4:	f481ba03          	ld	s4,-184(gp) # 11768 <_global_impure_ptr>
   105b8:	03213823          	sd	s2,48(sp)
   105bc:	04113423          	sd	ra,72(sp)
   105c0:	1f8a3903          	ld	s2,504(s4)
   105c4:	04813023          	sd	s0,64(sp)
   105c8:	02913c23          	sd	s1,56(sp)
   105cc:	03313423          	sd	s3,40(sp)
   105d0:	01513c23          	sd	s5,24(sp)
   105d4:	01613823          	sd	s6,16(sp)
   105d8:	01713423          	sd	s7,8(sp)
   105dc:	01813023          	sd	s8,0(sp)
   105e0:	04090063          	beqz	s2,10620 <__call_exitprocs+0x74>
   105e4:	00050b13          	mv	s6,a0
   105e8:	00058b93          	mv	s7,a1
   105ec:	00100a93          	li	s5,1
   105f0:	fff00993          	li	s3,-1
   105f4:	00892483          	lw	s1,8(s2)
   105f8:	fff4841b          	addw	s0,s1,-1
   105fc:	02044263          	bltz	s0,10620 <__call_exitprocs+0x74>
   10600:	00349493          	sll	s1,s1,0x3
   10604:	009904b3          	add	s1,s2,s1
   10608:	040b8463          	beqz	s7,10650 <__call_exitprocs+0xa4>
   1060c:	2084b783          	ld	a5,520(s1)
   10610:	05778063          	beq	a5,s7,10650 <__call_exitprocs+0xa4>
   10614:	fff4041b          	addw	s0,s0,-1
   10618:	ff848493          	add	s1,s1,-8
   1061c:	ff3416e3          	bne	s0,s3,10608 <__call_exitprocs+0x5c>
   10620:	04813083          	ld	ra,72(sp)
   10624:	04013403          	ld	s0,64(sp)
   10628:	03813483          	ld	s1,56(sp)
   1062c:	03013903          	ld	s2,48(sp)
   10630:	02813983          	ld	s3,40(sp)
   10634:	02013a03          	ld	s4,32(sp)
   10638:	01813a83          	ld	s5,24(sp)
   1063c:	01013b03          	ld	s6,16(sp)
   10640:	00813b83          	ld	s7,8(sp)
   10644:	00013c03          	ld	s8,0(sp)
   10648:	05010113          	add	sp,sp,80
   1064c:	00008067          	ret
   10650:	00892783          	lw	a5,8(s2)
   10654:	0084b703          	ld	a4,8(s1)
   10658:	fff7879b          	addw	a5,a5,-1
   1065c:	06878263          	beq	a5,s0,106c0 <__call_exitprocs+0x114>
   10660:	0004b423          	sd	zero,8(s1)
   10664:	fa0708e3          	beqz	a4,10614 <__call_exitprocs+0x68>
   10668:	31092783          	lw	a5,784(s2)
   1066c:	008a96bb          	sllw	a3,s5,s0
   10670:	00892c03          	lw	s8,8(s2)
   10674:	00d7f7b3          	and	a5,a5,a3
   10678:	0007879b          	sext.w	a5,a5
   1067c:	02079263          	bnez	a5,106a0 <__call_exitprocs+0xf4>
   10680:	000700e7          	jalr	a4
   10684:	00892703          	lw	a4,8(s2)
   10688:	1f8a3783          	ld	a5,504(s4)
   1068c:	01871463          	bne	a4,s8,10694 <__call_exitprocs+0xe8>
   10690:	f92782e3          	beq	a5,s2,10614 <__call_exitprocs+0x68>
   10694:	f80786e3          	beqz	a5,10620 <__call_exitprocs+0x74>
   10698:	00078913          	mv	s2,a5
   1069c:	f59ff06f          	j	105f4 <__call_exitprocs+0x48>
   106a0:	31492783          	lw	a5,788(s2)
   106a4:	1084b583          	ld	a1,264(s1)
   106a8:	00d7f7b3          	and	a5,a5,a3
   106ac:	0007879b          	sext.w	a5,a5
   106b0:	00079c63          	bnez	a5,106c8 <__call_exitprocs+0x11c>
   106b4:	000b0513          	mv	a0,s6
   106b8:	000700e7          	jalr	a4
   106bc:	fc9ff06f          	j	10684 <__call_exitprocs+0xd8>
   106c0:	00892423          	sw	s0,8(s2)
   106c4:	fa1ff06f          	j	10664 <__call_exitprocs+0xb8>
   106c8:	00058513          	mv	a0,a1
   106cc:	000700e7          	jalr	a4
   106d0:	fb5ff06f          	j	10684 <__call_exitprocs+0xd8>

00000000000106d4 <__libc_fini_array>:
   106d4:	fe010113          	add	sp,sp,-32
   106d8:	00813823          	sd	s0,16(sp)
   106dc:	000117b7          	lui	a5,0x11
   106e0:	00011437          	lui	s0,0x11
   106e4:	01878793          	add	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   106e8:	02040413          	add	s0,s0,32 # 11020 <impure_data>
   106ec:	40f40433          	sub	s0,s0,a5
   106f0:	00913423          	sd	s1,8(sp)
   106f4:	00113c23          	sd	ra,24(sp)
   106f8:	40345493          	sra	s1,s0,0x3
   106fc:	02048063          	beqz	s1,1071c <__libc_fini_array+0x48>
   10700:	ff840413          	add	s0,s0,-8
   10704:	00f40433          	add	s0,s0,a5
   10708:	00043783          	ld	a5,0(s0)
   1070c:	fff48493          	add	s1,s1,-1
   10710:	ff840413          	add	s0,s0,-8
   10714:	000780e7          	jalr	a5
   10718:	fe0498e3          	bnez	s1,10708 <__libc_fini_array+0x34>
   1071c:	01813083          	ld	ra,24(sp)
   10720:	01013403          	ld	s0,16(sp)
   10724:	00813483          	ld	s1,8(sp)
   10728:	02010113          	add	sp,sp,32
   1072c:	00008067          	ret

0000000000010730 <atexit>:
   10730:	00050593          	mv	a1,a0
   10734:	00000693          	li	a3,0
   10738:	00000613          	li	a2,0
   1073c:	00000513          	li	a0,0
   10740:	0040006f          	j	10744 <__register_exitproc>

0000000000010744 <__register_exitproc>:
   10744:	f481b703          	ld	a4,-184(gp) # 11768 <_global_impure_ptr>
   10748:	1f873783          	ld	a5,504(a4)
   1074c:	06078063          	beqz	a5,107ac <__register_exitproc+0x68>
   10750:	0087a703          	lw	a4,8(a5)
   10754:	01f00813          	li	a6,31
   10758:	08e84663          	blt	a6,a4,107e4 <__register_exitproc+0xa0>
   1075c:	02050863          	beqz	a0,1078c <__register_exitproc+0x48>
   10760:	00371813          	sll	a6,a4,0x3
   10764:	01078833          	add	a6,a5,a6
   10768:	10c83823          	sd	a2,272(a6)
   1076c:	3107a883          	lw	a7,784(a5)
   10770:	00100613          	li	a2,1
   10774:	00e6163b          	sllw	a2,a2,a4
   10778:	00c8e8b3          	or	a7,a7,a2
   1077c:	3117a823          	sw	a7,784(a5)
   10780:	20d83823          	sd	a3,528(a6)
   10784:	00200693          	li	a3,2
   10788:	02d50863          	beq	a0,a3,107b8 <__register_exitproc+0x74>
   1078c:	00270693          	add	a3,a4,2
   10790:	00369693          	sll	a3,a3,0x3
   10794:	0017071b          	addw	a4,a4,1
   10798:	00e7a423          	sw	a4,8(a5)
   1079c:	00d787b3          	add	a5,a5,a3
   107a0:	00b7b023          	sd	a1,0(a5)
   107a4:	00000513          	li	a0,0
   107a8:	00008067          	ret
   107ac:	20070793          	add	a5,a4,512
   107b0:	1ef73c23          	sd	a5,504(a4)
   107b4:	f9dff06f          	j	10750 <__register_exitproc+0xc>
   107b8:	3147a683          	lw	a3,788(a5)
   107bc:	00000513          	li	a0,0
   107c0:	00c6e6b3          	or	a3,a3,a2
   107c4:	30d7aa23          	sw	a3,788(a5)
   107c8:	00270693          	add	a3,a4,2
   107cc:	00369693          	sll	a3,a3,0x3
   107d0:	0017071b          	addw	a4,a4,1
   107d4:	00e7a423          	sw	a4,8(a5)
   107d8:	00d787b3          	add	a5,a5,a3
   107dc:	00b7b023          	sd	a1,0(a5)
   107e0:	00008067          	ret
   107e4:	fff00513          	li	a0,-1
   107e8:	00008067          	ret

00000000000107ec <_exit>:
   107ec:	05d00893          	li	a7,93
   107f0:	00000073          	ecall
   107f4:	00054463          	bltz	a0,107fc <_exit+0x10>
   107f8:	0000006f          	j	107f8 <_exit+0xc>
   107fc:	ff010113          	add	sp,sp,-16
   10800:	00813023          	sd	s0,0(sp)
   10804:	00050413          	mv	s0,a0
   10808:	00113423          	sd	ra,8(sp)
   1080c:	4080043b          	negw	s0,s0
   10810:	00c000ef          	jal	1081c <__errno>
   10814:	00852023          	sw	s0,0(a0) # 11000 <__EH_FRAME_BEGIN__>
   10818:	0000006f          	j	10818 <_exit+0x2c>

000000000001081c <__errno>:
   1081c:	f581b503          	ld	a0,-168(gp) # 11778 <_impure_ptr>
   10820:	00008067          	ret
