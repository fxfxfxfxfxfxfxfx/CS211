
../riscv-elf/test_float_1.riscv:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	42c000ef          	jal	10528 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11f10 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	654000ef          	jal	10768 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	65050513          	add	a0,a0,1616 # 10650 <__libc_fini_array>
   10128:	5840006f          	j	106ac <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00002197          	auipc	gp,0x2
   10134:	e9818193          	add	gp,gp,-360 # 11fc8 <__global_pointer$>
   10138:	f6018513          	add	a0,gp,-160 # 11f28 <completed.1>
   1013c:	f9818613          	add	a2,gp,-104 # 11f60 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	304000ef          	jal	1044c <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	56050513          	add	a0,a0,1376 # 106ac <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	4f850513          	add	a0,a0,1272 # 10650 <__libc_fini_array>
   10160:	54c000ef          	jal	106ac <atexit>
   10164:	24c000ef          	jal	103b0 <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	add	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	06c000ef          	jal	101e0 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	add	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11f28 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	7a850513          	add	a0,a0,1960 # 117a8 <__EH_FRAME_BEGIN__>
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11f28 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	add	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	f6818593          	add	a1,gp,-152 # 11f30 <object.0>
   101d0:	7a850513          	add	a0,a0,1960 # 117a8 <__EH_FRAME_BEGIN__>
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <main>:
   101e0:	fd010113          	add	sp,sp,-48
   101e4:	02113423          	sd	ra,40(sp)
   101e8:	02813023          	sd	s0,32(sp)
   101ec:	03010413          	add	s0,sp,48
   101f0:	00100793          	li	a5,1
   101f4:	fef42623          	sw	a5,-20(s0)
   101f8:	00200793          	li	a5,2
   101fc:	fef42423          	sw	a5,-24(s0)
   10200:	000107b7          	lui	a5,0x10
   10204:	7a07a787          	flw	fa5,1952(a5) # 107a0 <__errno+0x8>
   10208:	fef42227          	fsw	fa5,-28(s0)
   1020c:	000107b7          	lui	a5,0x10
   10210:	7a47a787          	flw	fa5,1956(a5) # 107a4 <__errno+0xc>
   10214:	fef42027          	fsw	fa5,-32(s0)
   10218:	fec42783          	lw	a5,-20(s0)
   1021c:	00078713          	mv	a4,a5
   10220:	fe842783          	lw	a5,-24(s0)
   10224:	00f707bb          	addw	a5,a4,a5
   10228:	fcf42e23          	sw	a5,-36(s0)
   1022c:	fdc42783          	lw	a5,-36(s0)
   10230:	00078513          	mv	a0,a5
   10234:	050000ef          	jal	10284 <print_d>
   10238:	fe442707          	flw	fa4,-28(s0)
   1023c:	fe042787          	flw	fa5,-32(s0)
   10240:	00f777d3          	fadd.s	fa5,fa4,fa5
   10244:	fcf42c27          	fsw	fa5,-40(s0)
   10248:	fd842507          	flw	fa0,-40(s0)
   1024c:	13c000ef          	jal	10388 <print_f>
   10250:	fe442707          	flw	fa4,-28(s0)
   10254:	fe042787          	flw	fa5,-32(s0)
   10258:	10f777d3          	fmul.s	fa5,fa4,fa5
   1025c:	fcf42a27          	fsw	fa5,-44(s0)
   10260:	fd442507          	flw	fa0,-44(s0)
   10264:	124000ef          	jal	10388 <print_f>
   10268:	09c000ef          	jal	10304 <exit_proc>
   1026c:	00000793          	li	a5,0
   10270:	00078513          	mv	a0,a5
   10274:	02813083          	ld	ra,40(sp)
   10278:	02013403          	ld	s0,32(sp)
   1027c:	03010113          	add	sp,sp,48
   10280:	00008067          	ret

0000000000010284 <print_d>:
   10284:	fe010113          	add	sp,sp,-32
   10288:	00813c23          	sd	s0,24(sp)
   1028c:	02010413          	add	s0,sp,32
   10290:	00050793          	mv	a5,a0
   10294:	fef42623          	sw	a5,-20(s0)
   10298:	00200893          	li	a7,2
   1029c:	00000073          	ecall
   102a0:	00000013          	nop
   102a4:	01813403          	ld	s0,24(sp)
   102a8:	02010113          	add	sp,sp,32
   102ac:	00008067          	ret

00000000000102b0 <print_s>:
   102b0:	fe010113          	add	sp,sp,-32
   102b4:	00813c23          	sd	s0,24(sp)
   102b8:	02010413          	add	s0,sp,32
   102bc:	fea43423          	sd	a0,-24(s0)
   102c0:	00000893          	li	a7,0
   102c4:	00000073          	ecall
   102c8:	00000013          	nop
   102cc:	01813403          	ld	s0,24(sp)
   102d0:	02010113          	add	sp,sp,32
   102d4:	00008067          	ret

00000000000102d8 <print_c>:
   102d8:	fe010113          	add	sp,sp,-32
   102dc:	00813c23          	sd	s0,24(sp)
   102e0:	02010413          	add	s0,sp,32
   102e4:	00050793          	mv	a5,a0
   102e8:	fef407a3          	sb	a5,-17(s0)
   102ec:	00100893          	li	a7,1
   102f0:	00000073          	ecall
   102f4:	00000013          	nop
   102f8:	01813403          	ld	s0,24(sp)
   102fc:	02010113          	add	sp,sp,32
   10300:	00008067          	ret

0000000000010304 <exit_proc>:
   10304:	ff010113          	add	sp,sp,-16
   10308:	00813423          	sd	s0,8(sp)
   1030c:	01010413          	add	s0,sp,16
   10310:	00300893          	li	a7,3
   10314:	00000073          	ecall
   10318:	00000013          	nop
   1031c:	00813403          	ld	s0,8(sp)
   10320:	01010113          	add	sp,sp,16
   10324:	00008067          	ret

0000000000010328 <read_char>:
   10328:	fe010113          	add	sp,sp,-32
   1032c:	00813c23          	sd	s0,24(sp)
   10330:	02010413          	add	s0,sp,32
   10334:	00400893          	li	a7,4
   10338:	00000073          	ecall
   1033c:	00050793          	mv	a5,a0
   10340:	fef407a3          	sb	a5,-17(s0)
   10344:	fef44783          	lbu	a5,-17(s0)
   10348:	00078513          	mv	a0,a5
   1034c:	01813403          	ld	s0,24(sp)
   10350:	02010113          	add	sp,sp,32
   10354:	00008067          	ret

0000000000010358 <read_num>:
   10358:	fe010113          	add	sp,sp,-32
   1035c:	00813c23          	sd	s0,24(sp)
   10360:	02010413          	add	s0,sp,32
   10364:	00500893          	li	a7,5
   10368:	00000073          	ecall
   1036c:	00050793          	mv	a5,a0
   10370:	fef43423          	sd	a5,-24(s0)
   10374:	fe843783          	ld	a5,-24(s0)
   10378:	00078513          	mv	a0,a5
   1037c:	01813403          	ld	s0,24(sp)
   10380:	02010113          	add	sp,sp,32
   10384:	00008067          	ret

0000000000010388 <print_f>:
   10388:	fe010113          	add	sp,sp,-32
   1038c:	00813c23          	sd	s0,24(sp)
   10390:	02010413          	add	s0,sp,32
   10394:	fea42627          	fsw	fa0,-20(s0)
   10398:	00600893          	li	a7,6
   1039c:	00000073          	ecall
   103a0:	00000013          	nop
   103a4:	01813403          	ld	s0,24(sp)
   103a8:	02010113          	add	sp,sp,32
   103ac:	00008067          	ret

00000000000103b0 <__libc_init_array>:
   103b0:	fe010113          	add	sp,sp,-32
   103b4:	00813823          	sd	s0,16(sp)
   103b8:	000117b7          	lui	a5,0x11
   103bc:	00011437          	lui	s0,0x11
   103c0:	01213023          	sd	s2,0(sp)
   103c4:	7ac78793          	add	a5,a5,1964 # 117ac <__preinit_array_end>
   103c8:	7ac40713          	add	a4,s0,1964 # 117ac <__preinit_array_end>
   103cc:	00113c23          	sd	ra,24(sp)
   103d0:	00913423          	sd	s1,8(sp)
   103d4:	40e78933          	sub	s2,a5,a4
   103d8:	02e78263          	beq	a5,a4,103fc <__libc_init_array+0x4c>
   103dc:	40395913          	sra	s2,s2,0x3
   103e0:	7ac40413          	add	s0,s0,1964
   103e4:	00000493          	li	s1,0
   103e8:	00043783          	ld	a5,0(s0)
   103ec:	00148493          	add	s1,s1,1
   103f0:	00840413          	add	s0,s0,8
   103f4:	000780e7          	jalr	a5
   103f8:	ff24e8e3          	bltu	s1,s2,103e8 <__libc_init_array+0x38>
   103fc:	00011437          	lui	s0,0x11
   10400:	000117b7          	lui	a5,0x11
   10404:	7c078793          	add	a5,a5,1984 # 117c0 <__do_global_dtors_aux_fini_array_entry>
   10408:	7b040713          	add	a4,s0,1968 # 117b0 <__init_array_start>
   1040c:	40e78933          	sub	s2,a5,a4
   10410:	40395913          	sra	s2,s2,0x3
   10414:	02e78063          	beq	a5,a4,10434 <__libc_init_array+0x84>
   10418:	7b040413          	add	s0,s0,1968
   1041c:	00000493          	li	s1,0
   10420:	00043783          	ld	a5,0(s0)
   10424:	00148493          	add	s1,s1,1
   10428:	00840413          	add	s0,s0,8
   1042c:	000780e7          	jalr	a5
   10430:	ff24e8e3          	bltu	s1,s2,10420 <__libc_init_array+0x70>
   10434:	01813083          	ld	ra,24(sp)
   10438:	01013403          	ld	s0,16(sp)
   1043c:	00813483          	ld	s1,8(sp)
   10440:	00013903          	ld	s2,0(sp)
   10444:	02010113          	add	sp,sp,32
   10448:	00008067          	ret

000000000001044c <memset>:
   1044c:	00f00313          	li	t1,15
   10450:	00050713          	mv	a4,a0
   10454:	02c37a63          	bgeu	t1,a2,10488 <memset+0x3c>
   10458:	00f77793          	and	a5,a4,15
   1045c:	0a079063          	bnez	a5,104fc <memset+0xb0>
   10460:	06059e63          	bnez	a1,104dc <memset+0x90>
   10464:	ff067693          	and	a3,a2,-16
   10468:	00f67613          	and	a2,a2,15
   1046c:	00e686b3          	add	a3,a3,a4
   10470:	00b73023          	sd	a1,0(a4)
   10474:	00b73423          	sd	a1,8(a4)
   10478:	01070713          	add	a4,a4,16
   1047c:	fed76ae3          	bltu	a4,a3,10470 <memset+0x24>
   10480:	00061463          	bnez	a2,10488 <memset+0x3c>
   10484:	00008067          	ret
   10488:	40c306b3          	sub	a3,t1,a2
   1048c:	00269693          	sll	a3,a3,0x2
   10490:	00000297          	auipc	t0,0x0
   10494:	005686b3          	add	a3,a3,t0
   10498:	00c68067          	jr	12(a3)
   1049c:	00b70723          	sb	a1,14(a4)
   104a0:	00b706a3          	sb	a1,13(a4)
   104a4:	00b70623          	sb	a1,12(a4)
   104a8:	00b705a3          	sb	a1,11(a4)
   104ac:	00b70523          	sb	a1,10(a4)
   104b0:	00b704a3          	sb	a1,9(a4)
   104b4:	00b70423          	sb	a1,8(a4)
   104b8:	00b703a3          	sb	a1,7(a4)
   104bc:	00b70323          	sb	a1,6(a4)
   104c0:	00b702a3          	sb	a1,5(a4)
   104c4:	00b70223          	sb	a1,4(a4)
   104c8:	00b701a3          	sb	a1,3(a4)
   104cc:	00b70123          	sb	a1,2(a4)
   104d0:	00b700a3          	sb	a1,1(a4)
   104d4:	00b70023          	sb	a1,0(a4)
   104d8:	00008067          	ret
   104dc:	0ff5f593          	zext.b	a1,a1
   104e0:	00859693          	sll	a3,a1,0x8
   104e4:	00d5e5b3          	or	a1,a1,a3
   104e8:	01059693          	sll	a3,a1,0x10
   104ec:	00d5e5b3          	or	a1,a1,a3
   104f0:	02059693          	sll	a3,a1,0x20
   104f4:	00d5e5b3          	or	a1,a1,a3
   104f8:	f6dff06f          	j	10464 <memset+0x18>
   104fc:	00279693          	sll	a3,a5,0x2
   10500:	00000297          	auipc	t0,0x0
   10504:	005686b3          	add	a3,a3,t0
   10508:	00008293          	mv	t0,ra
   1050c:	f98680e7          	jalr	-104(a3)
   10510:	00028093          	mv	ra,t0
   10514:	ff078793          	add	a5,a5,-16
   10518:	40f70733          	sub	a4,a4,a5
   1051c:	00f60633          	add	a2,a2,a5
   10520:	f6c374e3          	bgeu	t1,a2,10488 <memset+0x3c>
   10524:	f3dff06f          	j	10460 <memset+0x14>

0000000000010528 <__call_exitprocs>:
   10528:	fb010113          	add	sp,sp,-80
   1052c:	03413023          	sd	s4,32(sp)
   10530:	f481ba03          	ld	s4,-184(gp) # 11f10 <_global_impure_ptr>
   10534:	03213823          	sd	s2,48(sp)
   10538:	04113423          	sd	ra,72(sp)
   1053c:	1f8a3903          	ld	s2,504(s4)
   10540:	04813023          	sd	s0,64(sp)
   10544:	02913c23          	sd	s1,56(sp)
   10548:	03313423          	sd	s3,40(sp)
   1054c:	01513c23          	sd	s5,24(sp)
   10550:	01613823          	sd	s6,16(sp)
   10554:	01713423          	sd	s7,8(sp)
   10558:	01813023          	sd	s8,0(sp)
   1055c:	04090063          	beqz	s2,1059c <__call_exitprocs+0x74>
   10560:	00050b13          	mv	s6,a0
   10564:	00058b93          	mv	s7,a1
   10568:	00100a93          	li	s5,1
   1056c:	fff00993          	li	s3,-1
   10570:	00892483          	lw	s1,8(s2)
   10574:	fff4841b          	addw	s0,s1,-1
   10578:	02044263          	bltz	s0,1059c <__call_exitprocs+0x74>
   1057c:	00349493          	sll	s1,s1,0x3
   10580:	009904b3          	add	s1,s2,s1
   10584:	040b8463          	beqz	s7,105cc <__call_exitprocs+0xa4>
   10588:	2084b783          	ld	a5,520(s1)
   1058c:	05778063          	beq	a5,s7,105cc <__call_exitprocs+0xa4>
   10590:	fff4041b          	addw	s0,s0,-1
   10594:	ff848493          	add	s1,s1,-8
   10598:	ff3416e3          	bne	s0,s3,10584 <__call_exitprocs+0x5c>
   1059c:	04813083          	ld	ra,72(sp)
   105a0:	04013403          	ld	s0,64(sp)
   105a4:	03813483          	ld	s1,56(sp)
   105a8:	03013903          	ld	s2,48(sp)
   105ac:	02813983          	ld	s3,40(sp)
   105b0:	02013a03          	ld	s4,32(sp)
   105b4:	01813a83          	ld	s5,24(sp)
   105b8:	01013b03          	ld	s6,16(sp)
   105bc:	00813b83          	ld	s7,8(sp)
   105c0:	00013c03          	ld	s8,0(sp)
   105c4:	05010113          	add	sp,sp,80
   105c8:	00008067          	ret
   105cc:	00892783          	lw	a5,8(s2)
   105d0:	0084b703          	ld	a4,8(s1)
   105d4:	fff7879b          	addw	a5,a5,-1
   105d8:	06878263          	beq	a5,s0,1063c <__call_exitprocs+0x114>
   105dc:	0004b423          	sd	zero,8(s1)
   105e0:	fa0708e3          	beqz	a4,10590 <__call_exitprocs+0x68>
   105e4:	31092783          	lw	a5,784(s2)
   105e8:	008a96bb          	sllw	a3,s5,s0
   105ec:	00892c03          	lw	s8,8(s2)
   105f0:	00d7f7b3          	and	a5,a5,a3
   105f4:	0007879b          	sext.w	a5,a5
   105f8:	02079263          	bnez	a5,1061c <__call_exitprocs+0xf4>
   105fc:	000700e7          	jalr	a4
   10600:	00892703          	lw	a4,8(s2)
   10604:	1f8a3783          	ld	a5,504(s4)
   10608:	01871463          	bne	a4,s8,10610 <__call_exitprocs+0xe8>
   1060c:	f92782e3          	beq	a5,s2,10590 <__call_exitprocs+0x68>
   10610:	f80786e3          	beqz	a5,1059c <__call_exitprocs+0x74>
   10614:	00078913          	mv	s2,a5
   10618:	f59ff06f          	j	10570 <__call_exitprocs+0x48>
   1061c:	31492783          	lw	a5,788(s2)
   10620:	1084b583          	ld	a1,264(s1)
   10624:	00d7f7b3          	and	a5,a5,a3
   10628:	0007879b          	sext.w	a5,a5
   1062c:	00079c63          	bnez	a5,10644 <__call_exitprocs+0x11c>
   10630:	000b0513          	mv	a0,s6
   10634:	000700e7          	jalr	a4
   10638:	fc9ff06f          	j	10600 <__call_exitprocs+0xd8>
   1063c:	00892423          	sw	s0,8(s2)
   10640:	fa1ff06f          	j	105e0 <__call_exitprocs+0xb8>
   10644:	00058513          	mv	a0,a1
   10648:	000700e7          	jalr	a4
   1064c:	fb5ff06f          	j	10600 <__call_exitprocs+0xd8>

0000000000010650 <__libc_fini_array>:
   10650:	fe010113          	add	sp,sp,-32
   10654:	00813823          	sd	s0,16(sp)
   10658:	000117b7          	lui	a5,0x11
   1065c:	00011437          	lui	s0,0x11
   10660:	7c078793          	add	a5,a5,1984 # 117c0 <__do_global_dtors_aux_fini_array_entry>
   10664:	7c840413          	add	s0,s0,1992 # 117c8 <impure_data>
   10668:	40f40433          	sub	s0,s0,a5
   1066c:	00913423          	sd	s1,8(sp)
   10670:	00113c23          	sd	ra,24(sp)
   10674:	40345493          	sra	s1,s0,0x3
   10678:	02048063          	beqz	s1,10698 <__libc_fini_array+0x48>
   1067c:	ff840413          	add	s0,s0,-8
   10680:	00f40433          	add	s0,s0,a5
   10684:	00043783          	ld	a5,0(s0)
   10688:	fff48493          	add	s1,s1,-1
   1068c:	ff840413          	add	s0,s0,-8
   10690:	000780e7          	jalr	a5
   10694:	fe0498e3          	bnez	s1,10684 <__libc_fini_array+0x34>
   10698:	01813083          	ld	ra,24(sp)
   1069c:	01013403          	ld	s0,16(sp)
   106a0:	00813483          	ld	s1,8(sp)
   106a4:	02010113          	add	sp,sp,32
   106a8:	00008067          	ret

00000000000106ac <atexit>:
   106ac:	00050593          	mv	a1,a0
   106b0:	00000693          	li	a3,0
   106b4:	00000613          	li	a2,0
   106b8:	00000513          	li	a0,0
   106bc:	0040006f          	j	106c0 <__register_exitproc>

00000000000106c0 <__register_exitproc>:
   106c0:	f481b703          	ld	a4,-184(gp) # 11f10 <_global_impure_ptr>
   106c4:	1f873783          	ld	a5,504(a4)
   106c8:	06078063          	beqz	a5,10728 <__register_exitproc+0x68>
   106cc:	0087a703          	lw	a4,8(a5)
   106d0:	01f00813          	li	a6,31
   106d4:	08e84663          	blt	a6,a4,10760 <__register_exitproc+0xa0>
   106d8:	02050863          	beqz	a0,10708 <__register_exitproc+0x48>
   106dc:	00371813          	sll	a6,a4,0x3
   106e0:	01078833          	add	a6,a5,a6
   106e4:	10c83823          	sd	a2,272(a6)
   106e8:	3107a883          	lw	a7,784(a5)
   106ec:	00100613          	li	a2,1
   106f0:	00e6163b          	sllw	a2,a2,a4
   106f4:	00c8e8b3          	or	a7,a7,a2
   106f8:	3117a823          	sw	a7,784(a5)
   106fc:	20d83823          	sd	a3,528(a6)
   10700:	00200693          	li	a3,2
   10704:	02d50863          	beq	a0,a3,10734 <__register_exitproc+0x74>
   10708:	00270693          	add	a3,a4,2
   1070c:	00369693          	sll	a3,a3,0x3
   10710:	0017071b          	addw	a4,a4,1
   10714:	00e7a423          	sw	a4,8(a5)
   10718:	00d787b3          	add	a5,a5,a3
   1071c:	00b7b023          	sd	a1,0(a5)
   10720:	00000513          	li	a0,0
   10724:	00008067          	ret
   10728:	20070793          	add	a5,a4,512
   1072c:	1ef73c23          	sd	a5,504(a4)
   10730:	f9dff06f          	j	106cc <__register_exitproc+0xc>
   10734:	3147a683          	lw	a3,788(a5)
   10738:	00000513          	li	a0,0
   1073c:	00c6e6b3          	or	a3,a3,a2
   10740:	30d7aa23          	sw	a3,788(a5)
   10744:	00270693          	add	a3,a4,2
   10748:	00369693          	sll	a3,a3,0x3
   1074c:	0017071b          	addw	a4,a4,1
   10750:	00e7a423          	sw	a4,8(a5)
   10754:	00d787b3          	add	a5,a5,a3
   10758:	00b7b023          	sd	a1,0(a5)
   1075c:	00008067          	ret
   10760:	fff00513          	li	a0,-1
   10764:	00008067          	ret

0000000000010768 <_exit>:
   10768:	05d00893          	li	a7,93
   1076c:	00000073          	ecall
   10770:	00054463          	bltz	a0,10778 <_exit+0x10>
   10774:	0000006f          	j	10774 <_exit+0xc>
   10778:	ff010113          	add	sp,sp,-16
   1077c:	00813023          	sd	s0,0(sp)
   10780:	00050413          	mv	s0,a0
   10784:	00113423          	sd	ra,8(sp)
   10788:	4080043b          	negw	s0,s0
   1078c:	00c000ef          	jal	10798 <__errno>
   10790:	00852023          	sw	s0,0(a0)
   10794:	0000006f          	j	10794 <_exit+0x2c>

0000000000010798 <__errno>:
   10798:	f581b503          	ld	a0,-168(gp) # 11f20 <_impure_ptr>
   1079c:	00008067          	ret
