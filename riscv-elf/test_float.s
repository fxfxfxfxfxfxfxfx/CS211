
../riscv-elf/test_float.riscv:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	458000ef          	jal	10554 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11f40 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	680000ef          	jal	10794 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	67c50513          	add	a0,a0,1660 # 1067c <__libc_fini_array>
   10128:	5b00006f          	j	106d8 <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00002197          	auipc	gp,0x2
   10134:	ec818193          	add	gp,gp,-312 # 11ff8 <__global_pointer$>
   10138:	f6018513          	add	a0,gp,-160 # 11f58 <completed.1>
   1013c:	f9818613          	add	a2,gp,-104 # 11f90 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	330000ef          	jal	10478 <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	58c50513          	add	a0,a0,1420 # 106d8 <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	52450513          	add	a0,a0,1316 # 1067c <__libc_fini_array>
   10160:	578000ef          	jal	106d8 <atexit>
   10164:	278000ef          	jal	103dc <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	add	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	06c000ef          	jal	101e0 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	add	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11f58 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	7dc50513          	add	a0,a0,2012 # 117dc <__EH_FRAME_BEGIN__>
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11f58 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	add	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	f6818593          	add	a1,gp,-152 # 11f60 <object.0>
   101d0:	7dc50513          	add	a0,a0,2012 # 117dc <__EH_FRAME_BEGIN__>
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <main>:
   101e0:	fd010113          	add	sp,sp,-48
   101e4:	02113423          	sd	ra,40(sp)
   101e8:	02813023          	sd	s0,32(sp)
   101ec:	03010413          	add	s0,sp,48
   101f0:	000107b7          	lui	a5,0x10
   101f4:	7cc7a787          	flw	fa5,1996(a5) # 107cc <__errno+0x8>
   101f8:	fef42627          	fsw	fa5,-20(s0)
   101fc:	000107b7          	lui	a5,0x10
   10200:	7d07a787          	flw	fa5,2000(a5) # 107d0 <__errno+0xc>
   10204:	fef42427          	fsw	fa5,-24(s0)
   10208:	000107b7          	lui	a5,0x10
   1020c:	7d47a787          	flw	fa5,2004(a5) # 107d4 <__errno+0x10>
   10210:	fef42227          	fsw	fa5,-28(s0)
   10214:	000107b7          	lui	a5,0x10
   10218:	7d87a787          	flw	fa5,2008(a5) # 107d8 <__errno+0x14>
   1021c:	fef42027          	fsw	fa5,-32(s0)
   10220:	fec42787          	flw	fa5,-20(s0)
   10224:	fcf42e27          	fsw	fa5,-36(s0)
   10228:	00000013          	nop
   1022c:	00000013          	nop
   10230:	00000013          	nop
   10234:	00000013          	nop
   10238:	00000013          	nop
   1023c:	00000013          	nop
   10240:	00000013          	nop
   10244:	fdc42507          	flw	fa0,-36(s0)
   10248:	16c000ef          	jal	103b4 <print_f>
   1024c:	fec42707          	flw	fa4,-20(s0)
   10250:	fe842787          	flw	fa5,-24(s0)
   10254:	08f777d3          	fsub.s	fa5,fa4,fa5
   10258:	fcf42c27          	fsw	fa5,-40(s0)
   1025c:	fd842507          	flw	fa0,-40(s0)
   10260:	154000ef          	jal	103b4 <print_f>
   10264:	fe442707          	flw	fa4,-28(s0)
   10268:	fe042787          	flw	fa5,-32(s0)
   1026c:	10f777d3          	fmul.s	fa5,fa4,fa5
   10270:	fcf42a27          	fsw	fa5,-44(s0)
   10274:	fd442507          	flw	fa0,-44(s0)
   10278:	13c000ef          	jal	103b4 <print_f>
   1027c:	fe042707          	flw	fa4,-32(s0)
   10280:	fe442787          	flw	fa5,-28(s0)
   10284:	18f777d3          	fdiv.s	fa5,fa4,fa5
   10288:	fcf42e27          	fsw	fa5,-36(s0)
   1028c:	fdc42507          	flw	fa0,-36(s0)
   10290:	124000ef          	jal	103b4 <print_f>
   10294:	09c000ef          	jal	10330 <exit_proc>
   10298:	00000793          	li	a5,0
   1029c:	00078513          	mv	a0,a5
   102a0:	02813083          	ld	ra,40(sp)
   102a4:	02013403          	ld	s0,32(sp)
   102a8:	03010113          	add	sp,sp,48
   102ac:	00008067          	ret

00000000000102b0 <print_d>:
   102b0:	fe010113          	add	sp,sp,-32
   102b4:	00813c23          	sd	s0,24(sp)
   102b8:	02010413          	add	s0,sp,32
   102bc:	00050793          	mv	a5,a0
   102c0:	fef42623          	sw	a5,-20(s0)
   102c4:	00200893          	li	a7,2
   102c8:	00000073          	ecall
   102cc:	00000013          	nop
   102d0:	01813403          	ld	s0,24(sp)
   102d4:	02010113          	add	sp,sp,32
   102d8:	00008067          	ret

00000000000102dc <print_s>:
   102dc:	fe010113          	add	sp,sp,-32
   102e0:	00813c23          	sd	s0,24(sp)
   102e4:	02010413          	add	s0,sp,32
   102e8:	fea43423          	sd	a0,-24(s0)
   102ec:	00000893          	li	a7,0
   102f0:	00000073          	ecall
   102f4:	00000013          	nop
   102f8:	01813403          	ld	s0,24(sp)
   102fc:	02010113          	add	sp,sp,32
   10300:	00008067          	ret

0000000000010304 <print_c>:
   10304:	fe010113          	add	sp,sp,-32
   10308:	00813c23          	sd	s0,24(sp)
   1030c:	02010413          	add	s0,sp,32
   10310:	00050793          	mv	a5,a0
   10314:	fef407a3          	sb	a5,-17(s0)
   10318:	00100893          	li	a7,1
   1031c:	00000073          	ecall
   10320:	00000013          	nop
   10324:	01813403          	ld	s0,24(sp)
   10328:	02010113          	add	sp,sp,32
   1032c:	00008067          	ret

0000000000010330 <exit_proc>:
   10330:	ff010113          	add	sp,sp,-16
   10334:	00813423          	sd	s0,8(sp)
   10338:	01010413          	add	s0,sp,16
   1033c:	00300893          	li	a7,3
   10340:	00000073          	ecall
   10344:	00000013          	nop
   10348:	00813403          	ld	s0,8(sp)
   1034c:	01010113          	add	sp,sp,16
   10350:	00008067          	ret

0000000000010354 <read_char>:
   10354:	fe010113          	add	sp,sp,-32
   10358:	00813c23          	sd	s0,24(sp)
   1035c:	02010413          	add	s0,sp,32
   10360:	00400893          	li	a7,4
   10364:	00000073          	ecall
   10368:	00050793          	mv	a5,a0
   1036c:	fef407a3          	sb	a5,-17(s0)
   10370:	fef44783          	lbu	a5,-17(s0)
   10374:	00078513          	mv	a0,a5
   10378:	01813403          	ld	s0,24(sp)
   1037c:	02010113          	add	sp,sp,32
   10380:	00008067          	ret

0000000000010384 <read_num>:
   10384:	fe010113          	add	sp,sp,-32
   10388:	00813c23          	sd	s0,24(sp)
   1038c:	02010413          	add	s0,sp,32
   10390:	00500893          	li	a7,5
   10394:	00000073          	ecall
   10398:	00050793          	mv	a5,a0
   1039c:	fef43423          	sd	a5,-24(s0)
   103a0:	fe843783          	ld	a5,-24(s0)
   103a4:	00078513          	mv	a0,a5
   103a8:	01813403          	ld	s0,24(sp)
   103ac:	02010113          	add	sp,sp,32
   103b0:	00008067          	ret

00000000000103b4 <print_f>:
   103b4:	fe010113          	add	sp,sp,-32
   103b8:	00813c23          	sd	s0,24(sp)
   103bc:	02010413          	add	s0,sp,32
   103c0:	fea42627          	fsw	fa0,-20(s0)
   103c4:	00600893          	li	a7,6
   103c8:	00000073          	ecall
   103cc:	00000013          	nop
   103d0:	01813403          	ld	s0,24(sp)
   103d4:	02010113          	add	sp,sp,32
   103d8:	00008067          	ret

00000000000103dc <__libc_init_array>:
   103dc:	fe010113          	add	sp,sp,-32
   103e0:	00813823          	sd	s0,16(sp)
   103e4:	000117b7          	lui	a5,0x11
   103e8:	00011437          	lui	s0,0x11
   103ec:	01213023          	sd	s2,0(sp)
   103f0:	7e078793          	add	a5,a5,2016 # 117e0 <__init_array_start>
   103f4:	7e040713          	add	a4,s0,2016 # 117e0 <__init_array_start>
   103f8:	00113c23          	sd	ra,24(sp)
   103fc:	00913423          	sd	s1,8(sp)
   10400:	40e78933          	sub	s2,a5,a4
   10404:	02e78263          	beq	a5,a4,10428 <__libc_init_array+0x4c>
   10408:	40395913          	sra	s2,s2,0x3
   1040c:	7e040413          	add	s0,s0,2016
   10410:	00000493          	li	s1,0
   10414:	00043783          	ld	a5,0(s0)
   10418:	00148493          	add	s1,s1,1
   1041c:	00840413          	add	s0,s0,8
   10420:	000780e7          	jalr	a5
   10424:	ff24e8e3          	bltu	s1,s2,10414 <__libc_init_array+0x38>
   10428:	00011437          	lui	s0,0x11
   1042c:	000117b7          	lui	a5,0x11
   10430:	7f078793          	add	a5,a5,2032 # 117f0 <__do_global_dtors_aux_fini_array_entry>
   10434:	7e040713          	add	a4,s0,2016 # 117e0 <__init_array_start>
   10438:	40e78933          	sub	s2,a5,a4
   1043c:	40395913          	sra	s2,s2,0x3
   10440:	02e78063          	beq	a5,a4,10460 <__libc_init_array+0x84>
   10444:	7e040413          	add	s0,s0,2016
   10448:	00000493          	li	s1,0
   1044c:	00043783          	ld	a5,0(s0)
   10450:	00148493          	add	s1,s1,1
   10454:	00840413          	add	s0,s0,8
   10458:	000780e7          	jalr	a5
   1045c:	ff24e8e3          	bltu	s1,s2,1044c <__libc_init_array+0x70>
   10460:	01813083          	ld	ra,24(sp)
   10464:	01013403          	ld	s0,16(sp)
   10468:	00813483          	ld	s1,8(sp)
   1046c:	00013903          	ld	s2,0(sp)
   10470:	02010113          	add	sp,sp,32
   10474:	00008067          	ret

0000000000010478 <memset>:
   10478:	00f00313          	li	t1,15
   1047c:	00050713          	mv	a4,a0
   10480:	02c37a63          	bgeu	t1,a2,104b4 <memset+0x3c>
   10484:	00f77793          	and	a5,a4,15
   10488:	0a079063          	bnez	a5,10528 <memset+0xb0>
   1048c:	06059e63          	bnez	a1,10508 <memset+0x90>
   10490:	ff067693          	and	a3,a2,-16
   10494:	00f67613          	and	a2,a2,15
   10498:	00e686b3          	add	a3,a3,a4
   1049c:	00b73023          	sd	a1,0(a4)
   104a0:	00b73423          	sd	a1,8(a4)
   104a4:	01070713          	add	a4,a4,16
   104a8:	fed76ae3          	bltu	a4,a3,1049c <memset+0x24>
   104ac:	00061463          	bnez	a2,104b4 <memset+0x3c>
   104b0:	00008067          	ret
   104b4:	40c306b3          	sub	a3,t1,a2
   104b8:	00269693          	sll	a3,a3,0x2
   104bc:	00000297          	auipc	t0,0x0
   104c0:	005686b3          	add	a3,a3,t0
   104c4:	00c68067          	jr	12(a3)
   104c8:	00b70723          	sb	a1,14(a4)
   104cc:	00b706a3          	sb	a1,13(a4)
   104d0:	00b70623          	sb	a1,12(a4)
   104d4:	00b705a3          	sb	a1,11(a4)
   104d8:	00b70523          	sb	a1,10(a4)
   104dc:	00b704a3          	sb	a1,9(a4)
   104e0:	00b70423          	sb	a1,8(a4)
   104e4:	00b703a3          	sb	a1,7(a4)
   104e8:	00b70323          	sb	a1,6(a4)
   104ec:	00b702a3          	sb	a1,5(a4)
   104f0:	00b70223          	sb	a1,4(a4)
   104f4:	00b701a3          	sb	a1,3(a4)
   104f8:	00b70123          	sb	a1,2(a4)
   104fc:	00b700a3          	sb	a1,1(a4)
   10500:	00b70023          	sb	a1,0(a4)
   10504:	00008067          	ret
   10508:	0ff5f593          	zext.b	a1,a1
   1050c:	00859693          	sll	a3,a1,0x8
   10510:	00d5e5b3          	or	a1,a1,a3
   10514:	01059693          	sll	a3,a1,0x10
   10518:	00d5e5b3          	or	a1,a1,a3
   1051c:	02059693          	sll	a3,a1,0x20
   10520:	00d5e5b3          	or	a1,a1,a3
   10524:	f6dff06f          	j	10490 <memset+0x18>
   10528:	00279693          	sll	a3,a5,0x2
   1052c:	00000297          	auipc	t0,0x0
   10530:	005686b3          	add	a3,a3,t0
   10534:	00008293          	mv	t0,ra
   10538:	f98680e7          	jalr	-104(a3)
   1053c:	00028093          	mv	ra,t0
   10540:	ff078793          	add	a5,a5,-16
   10544:	40f70733          	sub	a4,a4,a5
   10548:	00f60633          	add	a2,a2,a5
   1054c:	f6c374e3          	bgeu	t1,a2,104b4 <memset+0x3c>
   10550:	f3dff06f          	j	1048c <memset+0x14>

0000000000010554 <__call_exitprocs>:
   10554:	fb010113          	add	sp,sp,-80
   10558:	03413023          	sd	s4,32(sp)
   1055c:	f481ba03          	ld	s4,-184(gp) # 11f40 <_global_impure_ptr>
   10560:	03213823          	sd	s2,48(sp)
   10564:	04113423          	sd	ra,72(sp)
   10568:	1f8a3903          	ld	s2,504(s4)
   1056c:	04813023          	sd	s0,64(sp)
   10570:	02913c23          	sd	s1,56(sp)
   10574:	03313423          	sd	s3,40(sp)
   10578:	01513c23          	sd	s5,24(sp)
   1057c:	01613823          	sd	s6,16(sp)
   10580:	01713423          	sd	s7,8(sp)
   10584:	01813023          	sd	s8,0(sp)
   10588:	04090063          	beqz	s2,105c8 <__call_exitprocs+0x74>
   1058c:	00050b13          	mv	s6,a0
   10590:	00058b93          	mv	s7,a1
   10594:	00100a93          	li	s5,1
   10598:	fff00993          	li	s3,-1
   1059c:	00892483          	lw	s1,8(s2)
   105a0:	fff4841b          	addw	s0,s1,-1
   105a4:	02044263          	bltz	s0,105c8 <__call_exitprocs+0x74>
   105a8:	00349493          	sll	s1,s1,0x3
   105ac:	009904b3          	add	s1,s2,s1
   105b0:	040b8463          	beqz	s7,105f8 <__call_exitprocs+0xa4>
   105b4:	2084b783          	ld	a5,520(s1)
   105b8:	05778063          	beq	a5,s7,105f8 <__call_exitprocs+0xa4>
   105bc:	fff4041b          	addw	s0,s0,-1
   105c0:	ff848493          	add	s1,s1,-8
   105c4:	ff3416e3          	bne	s0,s3,105b0 <__call_exitprocs+0x5c>
   105c8:	04813083          	ld	ra,72(sp)
   105cc:	04013403          	ld	s0,64(sp)
   105d0:	03813483          	ld	s1,56(sp)
   105d4:	03013903          	ld	s2,48(sp)
   105d8:	02813983          	ld	s3,40(sp)
   105dc:	02013a03          	ld	s4,32(sp)
   105e0:	01813a83          	ld	s5,24(sp)
   105e4:	01013b03          	ld	s6,16(sp)
   105e8:	00813b83          	ld	s7,8(sp)
   105ec:	00013c03          	ld	s8,0(sp)
   105f0:	05010113          	add	sp,sp,80
   105f4:	00008067          	ret
   105f8:	00892783          	lw	a5,8(s2)
   105fc:	0084b703          	ld	a4,8(s1)
   10600:	fff7879b          	addw	a5,a5,-1
   10604:	06878263          	beq	a5,s0,10668 <__call_exitprocs+0x114>
   10608:	0004b423          	sd	zero,8(s1)
   1060c:	fa0708e3          	beqz	a4,105bc <__call_exitprocs+0x68>
   10610:	31092783          	lw	a5,784(s2)
   10614:	008a96bb          	sllw	a3,s5,s0
   10618:	00892c03          	lw	s8,8(s2)
   1061c:	00d7f7b3          	and	a5,a5,a3
   10620:	0007879b          	sext.w	a5,a5
   10624:	02079263          	bnez	a5,10648 <__call_exitprocs+0xf4>
   10628:	000700e7          	jalr	a4
   1062c:	00892703          	lw	a4,8(s2)
   10630:	1f8a3783          	ld	a5,504(s4)
   10634:	01871463          	bne	a4,s8,1063c <__call_exitprocs+0xe8>
   10638:	f92782e3          	beq	a5,s2,105bc <__call_exitprocs+0x68>
   1063c:	f80786e3          	beqz	a5,105c8 <__call_exitprocs+0x74>
   10640:	00078913          	mv	s2,a5
   10644:	f59ff06f          	j	1059c <__call_exitprocs+0x48>
   10648:	31492783          	lw	a5,788(s2)
   1064c:	1084b583          	ld	a1,264(s1)
   10650:	00d7f7b3          	and	a5,a5,a3
   10654:	0007879b          	sext.w	a5,a5
   10658:	00079c63          	bnez	a5,10670 <__call_exitprocs+0x11c>
   1065c:	000b0513          	mv	a0,s6
   10660:	000700e7          	jalr	a4
   10664:	fc9ff06f          	j	1062c <__call_exitprocs+0xd8>
   10668:	00892423          	sw	s0,8(s2)
   1066c:	fa1ff06f          	j	1060c <__call_exitprocs+0xb8>
   10670:	00058513          	mv	a0,a1
   10674:	000700e7          	jalr	a4
   10678:	fb5ff06f          	j	1062c <__call_exitprocs+0xd8>

000000000001067c <__libc_fini_array>:
   1067c:	fe010113          	add	sp,sp,-32
   10680:	00813823          	sd	s0,16(sp)
   10684:	000117b7          	lui	a5,0x11
   10688:	00011437          	lui	s0,0x11
   1068c:	7f078793          	add	a5,a5,2032 # 117f0 <__do_global_dtors_aux_fini_array_entry>
   10690:	7f840413          	add	s0,s0,2040 # 117f8 <impure_data>
   10694:	40f40433          	sub	s0,s0,a5
   10698:	00913423          	sd	s1,8(sp)
   1069c:	00113c23          	sd	ra,24(sp)
   106a0:	40345493          	sra	s1,s0,0x3
   106a4:	02048063          	beqz	s1,106c4 <__libc_fini_array+0x48>
   106a8:	ff840413          	add	s0,s0,-8
   106ac:	00f40433          	add	s0,s0,a5
   106b0:	00043783          	ld	a5,0(s0)
   106b4:	fff48493          	add	s1,s1,-1
   106b8:	ff840413          	add	s0,s0,-8
   106bc:	000780e7          	jalr	a5
   106c0:	fe0498e3          	bnez	s1,106b0 <__libc_fini_array+0x34>
   106c4:	01813083          	ld	ra,24(sp)
   106c8:	01013403          	ld	s0,16(sp)
   106cc:	00813483          	ld	s1,8(sp)
   106d0:	02010113          	add	sp,sp,32
   106d4:	00008067          	ret

00000000000106d8 <atexit>:
   106d8:	00050593          	mv	a1,a0
   106dc:	00000693          	li	a3,0
   106e0:	00000613          	li	a2,0
   106e4:	00000513          	li	a0,0
   106e8:	0040006f          	j	106ec <__register_exitproc>

00000000000106ec <__register_exitproc>:
   106ec:	f481b703          	ld	a4,-184(gp) # 11f40 <_global_impure_ptr>
   106f0:	1f873783          	ld	a5,504(a4)
   106f4:	06078063          	beqz	a5,10754 <__register_exitproc+0x68>
   106f8:	0087a703          	lw	a4,8(a5)
   106fc:	01f00813          	li	a6,31
   10700:	08e84663          	blt	a6,a4,1078c <__register_exitproc+0xa0>
   10704:	02050863          	beqz	a0,10734 <__register_exitproc+0x48>
   10708:	00371813          	sll	a6,a4,0x3
   1070c:	01078833          	add	a6,a5,a6
   10710:	10c83823          	sd	a2,272(a6)
   10714:	3107a883          	lw	a7,784(a5)
   10718:	00100613          	li	a2,1
   1071c:	00e6163b          	sllw	a2,a2,a4
   10720:	00c8e8b3          	or	a7,a7,a2
   10724:	3117a823          	sw	a7,784(a5)
   10728:	20d83823          	sd	a3,528(a6)
   1072c:	00200693          	li	a3,2
   10730:	02d50863          	beq	a0,a3,10760 <__register_exitproc+0x74>
   10734:	00270693          	add	a3,a4,2
   10738:	00369693          	sll	a3,a3,0x3
   1073c:	0017071b          	addw	a4,a4,1
   10740:	00e7a423          	sw	a4,8(a5)
   10744:	00d787b3          	add	a5,a5,a3
   10748:	00b7b023          	sd	a1,0(a5)
   1074c:	00000513          	li	a0,0
   10750:	00008067          	ret
   10754:	20070793          	add	a5,a4,512
   10758:	1ef73c23          	sd	a5,504(a4)
   1075c:	f9dff06f          	j	106f8 <__register_exitproc+0xc>
   10760:	3147a683          	lw	a3,788(a5)
   10764:	00000513          	li	a0,0
   10768:	00c6e6b3          	or	a3,a3,a2
   1076c:	30d7aa23          	sw	a3,788(a5)
   10770:	00270693          	add	a3,a4,2
   10774:	00369693          	sll	a3,a3,0x3
   10778:	0017071b          	addw	a4,a4,1
   1077c:	00e7a423          	sw	a4,8(a5)
   10780:	00d787b3          	add	a5,a5,a3
   10784:	00b7b023          	sd	a1,0(a5)
   10788:	00008067          	ret
   1078c:	fff00513          	li	a0,-1
   10790:	00008067          	ret

0000000000010794 <_exit>:
   10794:	05d00893          	li	a7,93
   10798:	00000073          	ecall
   1079c:	00054463          	bltz	a0,107a4 <_exit+0x10>
   107a0:	0000006f          	j	107a0 <_exit+0xc>
   107a4:	ff010113          	add	sp,sp,-16
   107a8:	00813023          	sd	s0,0(sp)
   107ac:	00050413          	mv	s0,a0
   107b0:	00113423          	sd	ra,8(sp)
   107b4:	4080043b          	negw	s0,s0
   107b8:	00c000ef          	jal	107c4 <__errno>
   107bc:	00852023          	sw	s0,0(a0)
   107c0:	0000006f          	j	107c0 <_exit+0x2c>

00000000000107c4 <__errno>:
   107c4:	f581b503          	ld	a0,-168(gp) # 11f50 <_impure_ptr>
   107c8:	00008067          	ret
