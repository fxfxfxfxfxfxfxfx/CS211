
riscv-elf/test_float.riscv:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	464000ef          	jal	10560 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11f50 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	68c000ef          	jal	107a0 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	68850513          	add	a0,a0,1672 # 10688 <__libc_fini_array>
   10128:	5bc0006f          	j	106e4 <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00002197          	auipc	gp,0x2
   10134:	ed818193          	add	gp,gp,-296 # 12008 <__global_pointer$>
   10138:	f6018513          	add	a0,gp,-160 # 11f68 <completed.1>
   1013c:	f9818613          	add	a2,gp,-104 # 11fa0 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	33c000ef          	jal	10484 <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	59850513          	add	a0,a0,1432 # 106e4 <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	53050513          	add	a0,a0,1328 # 10688 <__libc_fini_array>
   10160:	584000ef          	jal	106e4 <atexit>
   10164:	284000ef          	jal	103e8 <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	add	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	06c000ef          	jal	101e0 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	add	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11f68 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	7e850513          	add	a0,a0,2024 # 117e8 <__EH_FRAME_BEGIN__>
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11f68 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	add	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	f6818593          	add	a1,gp,-152 # 11f70 <object.0>
   101d0:	7e850513          	add	a0,a0,2024 # 117e8 <__EH_FRAME_BEGIN__>
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <main>:
   101e0:	fd010113          	add	sp,sp,-48
   101e4:	02113423          	sd	ra,40(sp)
   101e8:	02813023          	sd	s0,32(sp)
   101ec:	03010413          	add	s0,sp,48
   101f0:	000107b7          	lui	a5,0x10
   101f4:	7d87a787          	flw	fa5,2008(a5) # 107d8 <__errno+0x8>
   101f8:	fef42627          	fsw	fa5,-20(s0)
   101fc:	000107b7          	lui	a5,0x10
   10200:	7dc7a787          	flw	fa5,2012(a5) # 107dc <__errno+0xc>
   10204:	fef42427          	fsw	fa5,-24(s0)
   10208:	000107b7          	lui	a5,0x10
   1020c:	7e07a787          	flw	fa5,2016(a5) # 107e0 <__errno+0x10>
   10210:	fef42227          	fsw	fa5,-28(s0)
   10214:	000107b7          	lui	a5,0x10
   10218:	7e47a787          	flw	fa5,2020(a5) # 107e4 <__errno+0x14>
   1021c:	fef42027          	fsw	fa5,-32(s0)
   10220:	fec42707          	flw	fa4,-20(s0)
   10224:	fe842787          	flw	fa5,-24(s0)
   10228:	00f777d3          	fadd.s	fa5,fa4,fa5
   1022c:	fcf42e27          	fsw	fa5,-36(s0)
   10230:	fdc42507          	flw	fa0,-36(s0)
   10234:	18c000ef          	jal	103c0 <print_f>
   10238:	00a00513          	li	a0,10
   1023c:	0d4000ef          	jal	10310 <print_c>
   10240:	fec42707          	flw	fa4,-20(s0)
   10244:	fe842787          	flw	fa5,-24(s0)
   10248:	08f777d3          	fsub.s	fa5,fa4,fa5
   1024c:	fcf42c27          	fsw	fa5,-40(s0)
   10250:	fd842507          	flw	fa0,-40(s0)
   10254:	16c000ef          	jal	103c0 <print_f>
   10258:	00a00513          	li	a0,10
   1025c:	0b4000ef          	jal	10310 <print_c>
   10260:	fe442707          	flw	fa4,-28(s0)
   10264:	fe042787          	flw	fa5,-32(s0)
   10268:	10f777d3          	fmul.s	fa5,fa4,fa5
   1026c:	fcf42a27          	fsw	fa5,-44(s0)
   10270:	fd442507          	flw	fa0,-44(s0)
   10274:	14c000ef          	jal	103c0 <print_f>
   10278:	00a00513          	li	a0,10
   1027c:	094000ef          	jal	10310 <print_c>
   10280:	fe042707          	flw	fa4,-32(s0)
   10284:	fe442787          	flw	fa5,-28(s0)
   10288:	18f777d3          	fdiv.s	fa5,fa4,fa5
   1028c:	fcf42e27          	fsw	fa5,-36(s0)
   10290:	fdc42507          	flw	fa0,-36(s0)
   10294:	12c000ef          	jal	103c0 <print_f>
   10298:	00a00513          	li	a0,10
   1029c:	074000ef          	jal	10310 <print_c>
   102a0:	09c000ef          	jal	1033c <exit_proc>
   102a4:	00000793          	li	a5,0
   102a8:	00078513          	mv	a0,a5
   102ac:	02813083          	ld	ra,40(sp)
   102b0:	02013403          	ld	s0,32(sp)
   102b4:	03010113          	add	sp,sp,48
   102b8:	00008067          	ret

00000000000102bc <print_d>:
   102bc:	fe010113          	add	sp,sp,-32
   102c0:	00813c23          	sd	s0,24(sp)
   102c4:	02010413          	add	s0,sp,32
   102c8:	00050793          	mv	a5,a0
   102cc:	fef42623          	sw	a5,-20(s0)
   102d0:	00200893          	li	a7,2
   102d4:	00000073          	ecall
   102d8:	00000013          	nop
   102dc:	01813403          	ld	s0,24(sp)
   102e0:	02010113          	add	sp,sp,32
   102e4:	00008067          	ret

00000000000102e8 <print_s>:
   102e8:	fe010113          	add	sp,sp,-32
   102ec:	00813c23          	sd	s0,24(sp)
   102f0:	02010413          	add	s0,sp,32
   102f4:	fea43423          	sd	a0,-24(s0)
   102f8:	00000893          	li	a7,0
   102fc:	00000073          	ecall
   10300:	00000013          	nop
   10304:	01813403          	ld	s0,24(sp)
   10308:	02010113          	add	sp,sp,32
   1030c:	00008067          	ret

0000000000010310 <print_c>:
   10310:	fe010113          	add	sp,sp,-32
   10314:	00813c23          	sd	s0,24(sp)
   10318:	02010413          	add	s0,sp,32
   1031c:	00050793          	mv	a5,a0
   10320:	fef407a3          	sb	a5,-17(s0)
   10324:	00100893          	li	a7,1
   10328:	00000073          	ecall
   1032c:	00000013          	nop
   10330:	01813403          	ld	s0,24(sp)
   10334:	02010113          	add	sp,sp,32
   10338:	00008067          	ret

000000000001033c <exit_proc>:
   1033c:	ff010113          	add	sp,sp,-16
   10340:	00813423          	sd	s0,8(sp)
   10344:	01010413          	add	s0,sp,16
   10348:	00300893          	li	a7,3
   1034c:	00000073          	ecall
   10350:	00000013          	nop
   10354:	00813403          	ld	s0,8(sp)
   10358:	01010113          	add	sp,sp,16
   1035c:	00008067          	ret

0000000000010360 <read_char>:
   10360:	fe010113          	add	sp,sp,-32
   10364:	00813c23          	sd	s0,24(sp)
   10368:	02010413          	add	s0,sp,32
   1036c:	00400893          	li	a7,4
   10370:	00000073          	ecall
   10374:	00050793          	mv	a5,a0
   10378:	fef407a3          	sb	a5,-17(s0)
   1037c:	fef44783          	lbu	a5,-17(s0)
   10380:	00078513          	mv	a0,a5
   10384:	01813403          	ld	s0,24(sp)
   10388:	02010113          	add	sp,sp,32
   1038c:	00008067          	ret

0000000000010390 <read_num>:
   10390:	fe010113          	add	sp,sp,-32
   10394:	00813c23          	sd	s0,24(sp)
   10398:	02010413          	add	s0,sp,32
   1039c:	00500893          	li	a7,5
   103a0:	00000073          	ecall
   103a4:	00050793          	mv	a5,a0
   103a8:	fef43423          	sd	a5,-24(s0)
   103ac:	fe843783          	ld	a5,-24(s0)
   103b0:	00078513          	mv	a0,a5
   103b4:	01813403          	ld	s0,24(sp)
   103b8:	02010113          	add	sp,sp,32
   103bc:	00008067          	ret

00000000000103c0 <print_f>:
   103c0:	fe010113          	add	sp,sp,-32
   103c4:	00813c23          	sd	s0,24(sp)
   103c8:	02010413          	add	s0,sp,32
   103cc:	fea42627          	fsw	fa0,-20(s0)
   103d0:	00600893          	li	a7,6
   103d4:	00000073          	ecall
   103d8:	00000013          	nop
   103dc:	01813403          	ld	s0,24(sp)
   103e0:	02010113          	add	sp,sp,32
   103e4:	00008067          	ret

00000000000103e8 <__libc_init_array>:
   103e8:	fe010113          	add	sp,sp,-32
   103ec:	00813823          	sd	s0,16(sp)
   103f0:	000117b7          	lui	a5,0x11
   103f4:	00011437          	lui	s0,0x11
   103f8:	01213023          	sd	s2,0(sp)
   103fc:	7ec78793          	add	a5,a5,2028 # 117ec <__preinit_array_end>
   10400:	7ec40713          	add	a4,s0,2028 # 117ec <__preinit_array_end>
   10404:	00113c23          	sd	ra,24(sp)
   10408:	00913423          	sd	s1,8(sp)
   1040c:	40e78933          	sub	s2,a5,a4
   10410:	02e78263          	beq	a5,a4,10434 <__libc_init_array+0x4c>
   10414:	40395913          	sra	s2,s2,0x3
   10418:	7ec40413          	add	s0,s0,2028
   1041c:	00000493          	li	s1,0
   10420:	00043783          	ld	a5,0(s0)
   10424:	00148493          	add	s1,s1,1
   10428:	00840413          	add	s0,s0,8
   1042c:	000780e7          	jalr	a5
   10430:	ff24e8e3          	bltu	s1,s2,10420 <__libc_init_array+0x38>
   10434:	00011437          	lui	s0,0x11
   10438:	000127b7          	lui	a5,0x12
   1043c:	80078793          	add	a5,a5,-2048 # 11800 <__do_global_dtors_aux_fini_array_entry>
   10440:	7f040713          	add	a4,s0,2032 # 117f0 <__init_array_start>
   10444:	40e78933          	sub	s2,a5,a4
   10448:	40395913          	sra	s2,s2,0x3
   1044c:	02e78063          	beq	a5,a4,1046c <__libc_init_array+0x84>
   10450:	7f040413          	add	s0,s0,2032
   10454:	00000493          	li	s1,0
   10458:	00043783          	ld	a5,0(s0)
   1045c:	00148493          	add	s1,s1,1
   10460:	00840413          	add	s0,s0,8
   10464:	000780e7          	jalr	a5
   10468:	ff24e8e3          	bltu	s1,s2,10458 <__libc_init_array+0x70>
   1046c:	01813083          	ld	ra,24(sp)
   10470:	01013403          	ld	s0,16(sp)
   10474:	00813483          	ld	s1,8(sp)
   10478:	00013903          	ld	s2,0(sp)
   1047c:	02010113          	add	sp,sp,32
   10480:	00008067          	ret

0000000000010484 <memset>:
   10484:	00f00313          	li	t1,15
   10488:	00050713          	mv	a4,a0
   1048c:	02c37a63          	bgeu	t1,a2,104c0 <memset+0x3c>
   10490:	00f77793          	and	a5,a4,15
   10494:	0a079063          	bnez	a5,10534 <memset+0xb0>
   10498:	06059e63          	bnez	a1,10514 <memset+0x90>
   1049c:	ff067693          	and	a3,a2,-16
   104a0:	00f67613          	and	a2,a2,15
   104a4:	00e686b3          	add	a3,a3,a4
   104a8:	00b73023          	sd	a1,0(a4)
   104ac:	00b73423          	sd	a1,8(a4)
   104b0:	01070713          	add	a4,a4,16
   104b4:	fed76ae3          	bltu	a4,a3,104a8 <memset+0x24>
   104b8:	00061463          	bnez	a2,104c0 <memset+0x3c>
   104bc:	00008067          	ret
   104c0:	40c306b3          	sub	a3,t1,a2
   104c4:	00269693          	sll	a3,a3,0x2
   104c8:	00000297          	auipc	t0,0x0
   104cc:	005686b3          	add	a3,a3,t0
   104d0:	00c68067          	jr	12(a3)
   104d4:	00b70723          	sb	a1,14(a4)
   104d8:	00b706a3          	sb	a1,13(a4)
   104dc:	00b70623          	sb	a1,12(a4)
   104e0:	00b705a3          	sb	a1,11(a4)
   104e4:	00b70523          	sb	a1,10(a4)
   104e8:	00b704a3          	sb	a1,9(a4)
   104ec:	00b70423          	sb	a1,8(a4)
   104f0:	00b703a3          	sb	a1,7(a4)
   104f4:	00b70323          	sb	a1,6(a4)
   104f8:	00b702a3          	sb	a1,5(a4)
   104fc:	00b70223          	sb	a1,4(a4)
   10500:	00b701a3          	sb	a1,3(a4)
   10504:	00b70123          	sb	a1,2(a4)
   10508:	00b700a3          	sb	a1,1(a4)
   1050c:	00b70023          	sb	a1,0(a4)
   10510:	00008067          	ret
   10514:	0ff5f593          	zext.b	a1,a1
   10518:	00859693          	sll	a3,a1,0x8
   1051c:	00d5e5b3          	or	a1,a1,a3
   10520:	01059693          	sll	a3,a1,0x10
   10524:	00d5e5b3          	or	a1,a1,a3
   10528:	02059693          	sll	a3,a1,0x20
   1052c:	00d5e5b3          	or	a1,a1,a3
   10530:	f6dff06f          	j	1049c <memset+0x18>
   10534:	00279693          	sll	a3,a5,0x2
   10538:	00000297          	auipc	t0,0x0
   1053c:	005686b3          	add	a3,a3,t0
   10540:	00008293          	mv	t0,ra
   10544:	f98680e7          	jalr	-104(a3)
   10548:	00028093          	mv	ra,t0
   1054c:	ff078793          	add	a5,a5,-16
   10550:	40f70733          	sub	a4,a4,a5
   10554:	00f60633          	add	a2,a2,a5
   10558:	f6c374e3          	bgeu	t1,a2,104c0 <memset+0x3c>
   1055c:	f3dff06f          	j	10498 <memset+0x14>

0000000000010560 <__call_exitprocs>:
   10560:	fb010113          	add	sp,sp,-80
   10564:	03413023          	sd	s4,32(sp)
   10568:	f481ba03          	ld	s4,-184(gp) # 11f50 <_global_impure_ptr>
   1056c:	03213823          	sd	s2,48(sp)
   10570:	04113423          	sd	ra,72(sp)
   10574:	1f8a3903          	ld	s2,504(s4)
   10578:	04813023          	sd	s0,64(sp)
   1057c:	02913c23          	sd	s1,56(sp)
   10580:	03313423          	sd	s3,40(sp)
   10584:	01513c23          	sd	s5,24(sp)
   10588:	01613823          	sd	s6,16(sp)
   1058c:	01713423          	sd	s7,8(sp)
   10590:	01813023          	sd	s8,0(sp)
   10594:	04090063          	beqz	s2,105d4 <__call_exitprocs+0x74>
   10598:	00050b13          	mv	s6,a0
   1059c:	00058b93          	mv	s7,a1
   105a0:	00100a93          	li	s5,1
   105a4:	fff00993          	li	s3,-1
   105a8:	00892483          	lw	s1,8(s2)
   105ac:	fff4841b          	addw	s0,s1,-1
   105b0:	02044263          	bltz	s0,105d4 <__call_exitprocs+0x74>
   105b4:	00349493          	sll	s1,s1,0x3
   105b8:	009904b3          	add	s1,s2,s1
   105bc:	040b8463          	beqz	s7,10604 <__call_exitprocs+0xa4>
   105c0:	2084b783          	ld	a5,520(s1)
   105c4:	05778063          	beq	a5,s7,10604 <__call_exitprocs+0xa4>
   105c8:	fff4041b          	addw	s0,s0,-1
   105cc:	ff848493          	add	s1,s1,-8
   105d0:	ff3416e3          	bne	s0,s3,105bc <__call_exitprocs+0x5c>
   105d4:	04813083          	ld	ra,72(sp)
   105d8:	04013403          	ld	s0,64(sp)
   105dc:	03813483          	ld	s1,56(sp)
   105e0:	03013903          	ld	s2,48(sp)
   105e4:	02813983          	ld	s3,40(sp)
   105e8:	02013a03          	ld	s4,32(sp)
   105ec:	01813a83          	ld	s5,24(sp)
   105f0:	01013b03          	ld	s6,16(sp)
   105f4:	00813b83          	ld	s7,8(sp)
   105f8:	00013c03          	ld	s8,0(sp)
   105fc:	05010113          	add	sp,sp,80
   10600:	00008067          	ret
   10604:	00892783          	lw	a5,8(s2)
   10608:	0084b703          	ld	a4,8(s1)
   1060c:	fff7879b          	addw	a5,a5,-1
   10610:	06878263          	beq	a5,s0,10674 <__call_exitprocs+0x114>
   10614:	0004b423          	sd	zero,8(s1)
   10618:	fa0708e3          	beqz	a4,105c8 <__call_exitprocs+0x68>
   1061c:	31092783          	lw	a5,784(s2)
   10620:	008a96bb          	sllw	a3,s5,s0
   10624:	00892c03          	lw	s8,8(s2)
   10628:	00d7f7b3          	and	a5,a5,a3
   1062c:	0007879b          	sext.w	a5,a5
   10630:	02079263          	bnez	a5,10654 <__call_exitprocs+0xf4>
   10634:	000700e7          	jalr	a4
   10638:	00892703          	lw	a4,8(s2)
   1063c:	1f8a3783          	ld	a5,504(s4)
   10640:	01871463          	bne	a4,s8,10648 <__call_exitprocs+0xe8>
   10644:	f92782e3          	beq	a5,s2,105c8 <__call_exitprocs+0x68>
   10648:	f80786e3          	beqz	a5,105d4 <__call_exitprocs+0x74>
   1064c:	00078913          	mv	s2,a5
   10650:	f59ff06f          	j	105a8 <__call_exitprocs+0x48>
   10654:	31492783          	lw	a5,788(s2)
   10658:	1084b583          	ld	a1,264(s1)
   1065c:	00d7f7b3          	and	a5,a5,a3
   10660:	0007879b          	sext.w	a5,a5
   10664:	00079c63          	bnez	a5,1067c <__call_exitprocs+0x11c>
   10668:	000b0513          	mv	a0,s6
   1066c:	000700e7          	jalr	a4
   10670:	fc9ff06f          	j	10638 <__call_exitprocs+0xd8>
   10674:	00892423          	sw	s0,8(s2)
   10678:	fa1ff06f          	j	10618 <__call_exitprocs+0xb8>
   1067c:	00058513          	mv	a0,a1
   10680:	000700e7          	jalr	a4
   10684:	fb5ff06f          	j	10638 <__call_exitprocs+0xd8>

0000000000010688 <__libc_fini_array>:
   10688:	fe010113          	add	sp,sp,-32
   1068c:	00813823          	sd	s0,16(sp)
   10690:	000127b7          	lui	a5,0x12
   10694:	00012437          	lui	s0,0x12
   10698:	80078793          	add	a5,a5,-2048 # 11800 <__do_global_dtors_aux_fini_array_entry>
   1069c:	80840413          	add	s0,s0,-2040 # 11808 <impure_data>
   106a0:	40f40433          	sub	s0,s0,a5
   106a4:	00913423          	sd	s1,8(sp)
   106a8:	00113c23          	sd	ra,24(sp)
   106ac:	40345493          	sra	s1,s0,0x3
   106b0:	02048063          	beqz	s1,106d0 <__libc_fini_array+0x48>
   106b4:	ff840413          	add	s0,s0,-8
   106b8:	00f40433          	add	s0,s0,a5
   106bc:	00043783          	ld	a5,0(s0)
   106c0:	fff48493          	add	s1,s1,-1
   106c4:	ff840413          	add	s0,s0,-8
   106c8:	000780e7          	jalr	a5
   106cc:	fe0498e3          	bnez	s1,106bc <__libc_fini_array+0x34>
   106d0:	01813083          	ld	ra,24(sp)
   106d4:	01013403          	ld	s0,16(sp)
   106d8:	00813483          	ld	s1,8(sp)
   106dc:	02010113          	add	sp,sp,32
   106e0:	00008067          	ret

00000000000106e4 <atexit>:
   106e4:	00050593          	mv	a1,a0
   106e8:	00000693          	li	a3,0
   106ec:	00000613          	li	a2,0
   106f0:	00000513          	li	a0,0
   106f4:	0040006f          	j	106f8 <__register_exitproc>

00000000000106f8 <__register_exitproc>:
   106f8:	f481b703          	ld	a4,-184(gp) # 11f50 <_global_impure_ptr>
   106fc:	1f873783          	ld	a5,504(a4)
   10700:	06078063          	beqz	a5,10760 <__register_exitproc+0x68>
   10704:	0087a703          	lw	a4,8(a5)
   10708:	01f00813          	li	a6,31
   1070c:	08e84663          	blt	a6,a4,10798 <__register_exitproc+0xa0>
   10710:	02050863          	beqz	a0,10740 <__register_exitproc+0x48>
   10714:	00371813          	sll	a6,a4,0x3
   10718:	01078833          	add	a6,a5,a6
   1071c:	10c83823          	sd	a2,272(a6)
   10720:	3107a883          	lw	a7,784(a5)
   10724:	00100613          	li	a2,1
   10728:	00e6163b          	sllw	a2,a2,a4
   1072c:	00c8e8b3          	or	a7,a7,a2
   10730:	3117a823          	sw	a7,784(a5)
   10734:	20d83823          	sd	a3,528(a6)
   10738:	00200693          	li	a3,2
   1073c:	02d50863          	beq	a0,a3,1076c <__register_exitproc+0x74>
   10740:	00270693          	add	a3,a4,2
   10744:	00369693          	sll	a3,a3,0x3
   10748:	0017071b          	addw	a4,a4,1
   1074c:	00e7a423          	sw	a4,8(a5)
   10750:	00d787b3          	add	a5,a5,a3
   10754:	00b7b023          	sd	a1,0(a5)
   10758:	00000513          	li	a0,0
   1075c:	00008067          	ret
   10760:	20070793          	add	a5,a4,512
   10764:	1ef73c23          	sd	a5,504(a4)
   10768:	f9dff06f          	j	10704 <__register_exitproc+0xc>
   1076c:	3147a683          	lw	a3,788(a5)
   10770:	00000513          	li	a0,0
   10774:	00c6e6b3          	or	a3,a3,a2
   10778:	30d7aa23          	sw	a3,788(a5)
   1077c:	00270693          	add	a3,a4,2
   10780:	00369693          	sll	a3,a3,0x3
   10784:	0017071b          	addw	a4,a4,1
   10788:	00e7a423          	sw	a4,8(a5)
   1078c:	00d787b3          	add	a5,a5,a3
   10790:	00b7b023          	sd	a1,0(a5)
   10794:	00008067          	ret
   10798:	fff00513          	li	a0,-1
   1079c:	00008067          	ret

00000000000107a0 <_exit>:
   107a0:	05d00893          	li	a7,93
   107a4:	00000073          	ecall
   107a8:	00054463          	bltz	a0,107b0 <_exit+0x10>
   107ac:	0000006f          	j	107ac <_exit+0xc>
   107b0:	ff010113          	add	sp,sp,-16
   107b4:	00813023          	sd	s0,0(sp)
   107b8:	00050413          	mv	s0,a0
   107bc:	00113423          	sd	ra,8(sp)
   107c0:	4080043b          	negw	s0,s0
   107c4:	00c000ef          	jal	107d0 <__errno>
   107c8:	00852023          	sw	s0,0(a0)
   107cc:	0000006f          	j	107cc <_exit+0x2c>

00000000000107d0 <__errno>:
   107d0:	f581b503          	ld	a0,-168(gp) # 11f60 <_impure_ptr>
   107d4:	00008067          	ret

Disassembly of section .rodata:

00000000000107d8 <.rodata>:
   107d8:	0fd0                	.2byte	0xfd0
   107da:	4049                	.2byte	0x4049
   107dc:	cac1                	.2byte	0xcac1
   107de:	4029                	.2byte	0x4029
   107e0:	0000                	.2byte	0x0
   107e2:	4040                	.2byte	0x4040
   107e4:	e666                	.2byte	0xe666
   107e6:	42f6                	.2byte	0x42f6

Disassembly of section .eh_frame:

00000000000117e8 <__EH_FRAME_BEGIN__>:
   117e8:	0000                	.2byte	0x0
	...

Disassembly of section .init_array:

00000000000117f0 <__init_array_start>:
   117f0:	0118                	.2byte	0x118
   117f2:	0001                	.2byte	0x1
   117f4:	0000                	.2byte	0x0
	...

00000000000117f8 <__frame_dummy_init_array_entry>:
   117f8:	01c0                	.2byte	0x1c0
   117fa:	0001                	.2byte	0x1
   117fc:	0000                	.2byte	0x0
	...

Disassembly of section .fini_array:

0000000000011800 <__do_global_dtors_aux_fini_array_entry>:
   11800:	017c                	.2byte	0x17c
   11802:	0001                	.2byte	0x1
   11804:	0000                	.2byte	0x0
	...

Disassembly of section .data:

0000000000011808 <impure_data>:
	...
   11810:	1d40                	.2byte	0x1d40
   11812:	0001                	.2byte	0x1
   11814:	0000                	.2byte	0x0
   11816:	0000                	.2byte	0x0
   11818:	1df0                	.2byte	0x1df0
   1181a:	0001                	.2byte	0x1
   1181c:	0000                	.2byte	0x0
   1181e:	0000                	.2byte	0x0
   11820:	1ea0                	.2byte	0x1ea0
   11822:	0001                	.2byte	0x1
	...
   118f0:	0001                	.2byte	0x1
   118f2:	0000                	.2byte	0x0
   118f4:	0000                	.2byte	0x0
   118f6:	0000                	.2byte	0x0
   118f8:	330e                	.2byte	0x330e
   118fa:	abcd                	.2byte	0xabcd
   118fc:	1234                	.2byte	0x1234
   118fe:	e66d                	.2byte	0xe66d
   11900:	deec                	.2byte	0xdeec
   11902:	0005                	.2byte	0x5
   11904:	0000000b          	.4byte	0xb
	...

Disassembly of section .sdata:

0000000000011f50 <_global_impure_ptr>:
   11f50:	1808                	.2byte	0x1808
   11f52:	0001                	.2byte	0x1
   11f54:	0000                	.2byte	0x0
	...

0000000000011f58 <__dso_handle>:
	...

0000000000011f60 <_impure_ptr>:
   11f60:	1808                	.2byte	0x1808
   11f62:	0001                	.2byte	0x1
   11f64:	0000                	.2byte	0x0
	...

Disassembly of section .bss:

0000000000011f68 <completed.1>:
	...

0000000000011f70 <object.0>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347          	.4byte	0x3a434347
   4:	2820                	.2byte	0x2820
   6:	65653267          	.4byte	0x65653267
   a:	6535                	.2byte	0x6535
   c:	3334                	.2byte	0x3334
   e:	3030                	.2byte	0x3030
  10:	3831                	.2byte	0x3831
  12:	2029                	.2byte	0x2029
  14:	3231                	.2byte	0x3231
  16:	322e                	.2byte	0x322e
  18:	302e                	.2byte	0x302e
  1a:	4700                	.2byte	0x4700
  1c:	203a4343          	fmadd.s	ft6,fs4,ft3,ft4,rmm
  20:	4728                	.2byte	0x4728
  22:	554e                	.2byte	0x554e
  24:	2029                	.2byte	0x2029
  26:	3231                	.2byte	0x3231
  28:	322e                	.2byte	0x322e
  2a:	302e                	.2byte	0x302e
	...

Disassembly of section .riscv.attributes:

0000000000000000 <.riscv.attributes>:
   0:	3741                	.2byte	0x3741
   2:	0000                	.2byte	0x0
   4:	7200                	.2byte	0x7200
   6:	7369                	.2byte	0x7369
   8:	01007663          	bgeu	zero,a6,14 <exit-0x100d4>
   c:	002d                	.2byte	0x2d
   e:	0000                	.2byte	0x0
  10:	1004                	.2byte	0x1004
  12:	7205                	.2byte	0x7205
  14:	3676                	.2byte	0x3676
  16:	6934                	.2byte	0x6934
  18:	7032                	.2byte	0x7032
  1a:	5f31                	.2byte	0x5f31
  1c:	326d                	.2byte	0x326d
  1e:	3070                	.2byte	0x3070
  20:	665f 7032 5f32      	.byte	0x5f, 0x66, 0x32, 0x70, 0x32, 0x5f
  26:	697a                	.2byte	0x697a
  28:	32727363          	bgeu	tp,t2,34e <exit-0xfd9a>
  2c:	3070                	.2byte	0x3070
  2e:	7a5f 6d6d 6c75      	.byte	0x5f, 0x7a, 0x6d, 0x6d, 0x75, 0x6c
  34:	7031                	.2byte	0x7031
  36:	0030                	.2byte	0x30
