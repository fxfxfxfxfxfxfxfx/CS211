
../riscv-elf/mytest.riscv:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	3fc000ef          	jal	104f8 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11ed8 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	624000ef          	jal	10738 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	62050513          	add	a0,a0,1568 # 10620 <__libc_fini_array>
   10128:	5540006f          	j	1067c <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00002197          	auipc	gp,0x2
   10134:	e6018193          	add	gp,gp,-416 # 11f90 <__global_pointer$>
   10138:	f6018513          	add	a0,gp,-160 # 11ef0 <completed.1>
   1013c:	f9818613          	add	a2,gp,-104 # 11f28 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	2d4000ef          	jal	1041c <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	53050513          	add	a0,a0,1328 # 1067c <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	4c850513          	add	a0,a0,1224 # 10620 <__libc_fini_array>
   10160:	51c000ef          	jal	1067c <atexit>
   10164:	21c000ef          	jal	10380 <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	add	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	06c000ef          	jal	101e0 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	add	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11ef0 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	77050513          	add	a0,a0,1904 # 11770 <__EH_FRAME_BEGIN__>
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11ef0 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	add	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	f6818593          	add	a1,gp,-152 # 11ef8 <object.0>
   101d0:	77050513          	add	a0,a0,1904 # 11770 <__EH_FRAME_BEGIN__>
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <main>:
   101e0:	fe010113          	add	sp,sp,-32
   101e4:	00113c23          	sd	ra,24(sp)
   101e8:	00813823          	sd	s0,16(sp)
   101ec:	02010413          	add	s0,sp,32
   101f0:	00100793          	li	a5,1
   101f4:	fef42623          	sw	a5,-20(s0)
   101f8:	fec42783          	lw	a5,-20(s0)
   101fc:	00078513          	mv	a0,a5
   10200:	054000ef          	jal	10254 <print_d>
   10204:	00200793          	li	a5,2
   10208:	fef42423          	sw	a5,-24(s0)
   1020c:	fe842783          	lw	a5,-24(s0)
   10210:	00078513          	mv	a0,a5
   10214:	040000ef          	jal	10254 <print_d>
   10218:	fec42783          	lw	a5,-20(s0)
   1021c:	00078713          	mv	a4,a5
   10220:	fe842783          	lw	a5,-24(s0)
   10224:	00f707bb          	addw	a5,a4,a5
   10228:	fef42223          	sw	a5,-28(s0)
   1022c:	fe442783          	lw	a5,-28(s0)
   10230:	00078513          	mv	a0,a5
   10234:	020000ef          	jal	10254 <print_d>
   10238:	09c000ef          	jal	102d4 <exit_proc>
   1023c:	00000793          	li	a5,0
   10240:	00078513          	mv	a0,a5
   10244:	01813083          	ld	ra,24(sp)
   10248:	01013403          	ld	s0,16(sp)
   1024c:	02010113          	add	sp,sp,32
   10250:	00008067          	ret

0000000000010254 <print_d>:
   10254:	fe010113          	add	sp,sp,-32
   10258:	00813c23          	sd	s0,24(sp)
   1025c:	02010413          	add	s0,sp,32
   10260:	00050793          	mv	a5,a0
   10264:	fef42623          	sw	a5,-20(s0)
   10268:	00200893          	li	a7,2
   1026c:	00000073          	ecall
   10270:	00000013          	nop
   10274:	01813403          	ld	s0,24(sp)
   10278:	02010113          	add	sp,sp,32
   1027c:	00008067          	ret

0000000000010280 <print_s>:
   10280:	fe010113          	add	sp,sp,-32
   10284:	00813c23          	sd	s0,24(sp)
   10288:	02010413          	add	s0,sp,32
   1028c:	fea43423          	sd	a0,-24(s0)
   10290:	00000893          	li	a7,0
   10294:	00000073          	ecall
   10298:	00000013          	nop
   1029c:	01813403          	ld	s0,24(sp)
   102a0:	02010113          	add	sp,sp,32
   102a4:	00008067          	ret

00000000000102a8 <print_c>:
   102a8:	fe010113          	add	sp,sp,-32
   102ac:	00813c23          	sd	s0,24(sp)
   102b0:	02010413          	add	s0,sp,32
   102b4:	00050793          	mv	a5,a0
   102b8:	fef407a3          	sb	a5,-17(s0)
   102bc:	00100893          	li	a7,1
   102c0:	00000073          	ecall
   102c4:	00000013          	nop
   102c8:	01813403          	ld	s0,24(sp)
   102cc:	02010113          	add	sp,sp,32
   102d0:	00008067          	ret

00000000000102d4 <exit_proc>:
   102d4:	ff010113          	add	sp,sp,-16
   102d8:	00813423          	sd	s0,8(sp)
   102dc:	01010413          	add	s0,sp,16
   102e0:	00300893          	li	a7,3
   102e4:	00000073          	ecall
   102e8:	00000013          	nop
   102ec:	00813403          	ld	s0,8(sp)
   102f0:	01010113          	add	sp,sp,16
   102f4:	00008067          	ret

00000000000102f8 <read_char>:
   102f8:	fe010113          	add	sp,sp,-32
   102fc:	00813c23          	sd	s0,24(sp)
   10300:	02010413          	add	s0,sp,32
   10304:	00400893          	li	a7,4
   10308:	00000073          	ecall
   1030c:	00050793          	mv	a5,a0
   10310:	fef407a3          	sb	a5,-17(s0)
   10314:	fef44783          	lbu	a5,-17(s0)
   10318:	00078513          	mv	a0,a5
   1031c:	01813403          	ld	s0,24(sp)
   10320:	02010113          	add	sp,sp,32
   10324:	00008067          	ret

0000000000010328 <read_num>:
   10328:	fe010113          	add	sp,sp,-32
   1032c:	00813c23          	sd	s0,24(sp)
   10330:	02010413          	add	s0,sp,32
   10334:	00500893          	li	a7,5
   10338:	00000073          	ecall
   1033c:	00050793          	mv	a5,a0
   10340:	fef43423          	sd	a5,-24(s0)
   10344:	fe843783          	ld	a5,-24(s0)
   10348:	00078513          	mv	a0,a5
   1034c:	01813403          	ld	s0,24(sp)
   10350:	02010113          	add	sp,sp,32
   10354:	00008067          	ret

0000000000010358 <print_f>:
   10358:	fe010113          	add	sp,sp,-32
   1035c:	00813c23          	sd	s0,24(sp)
   10360:	02010413          	add	s0,sp,32
   10364:	fea42627          	fsw	fa0,-20(s0)
   10368:	00600893          	li	a7,6
   1036c:	00000073          	ecall
   10370:	00000013          	nop
   10374:	01813403          	ld	s0,24(sp)
   10378:	02010113          	add	sp,sp,32
   1037c:	00008067          	ret

0000000000010380 <__libc_init_array>:
   10380:	fe010113          	add	sp,sp,-32
   10384:	00813823          	sd	s0,16(sp)
   10388:	000117b7          	lui	a5,0x11
   1038c:	00011437          	lui	s0,0x11
   10390:	01213023          	sd	s2,0(sp)
   10394:	77478793          	add	a5,a5,1908 # 11774 <__preinit_array_end>
   10398:	77440713          	add	a4,s0,1908 # 11774 <__preinit_array_end>
   1039c:	00113c23          	sd	ra,24(sp)
   103a0:	00913423          	sd	s1,8(sp)
   103a4:	40e78933          	sub	s2,a5,a4
   103a8:	02e78263          	beq	a5,a4,103cc <__libc_init_array+0x4c>
   103ac:	40395913          	sra	s2,s2,0x3
   103b0:	77440413          	add	s0,s0,1908
   103b4:	00000493          	li	s1,0
   103b8:	00043783          	ld	a5,0(s0)
   103bc:	00148493          	add	s1,s1,1
   103c0:	00840413          	add	s0,s0,8
   103c4:	000780e7          	jalr	a5
   103c8:	ff24e8e3          	bltu	s1,s2,103b8 <__libc_init_array+0x38>
   103cc:	00011437          	lui	s0,0x11
   103d0:	000117b7          	lui	a5,0x11
   103d4:	78878793          	add	a5,a5,1928 # 11788 <__do_global_dtors_aux_fini_array_entry>
   103d8:	77840713          	add	a4,s0,1912 # 11778 <__init_array_start>
   103dc:	40e78933          	sub	s2,a5,a4
   103e0:	40395913          	sra	s2,s2,0x3
   103e4:	02e78063          	beq	a5,a4,10404 <__libc_init_array+0x84>
   103e8:	77840413          	add	s0,s0,1912
   103ec:	00000493          	li	s1,0
   103f0:	00043783          	ld	a5,0(s0)
   103f4:	00148493          	add	s1,s1,1
   103f8:	00840413          	add	s0,s0,8
   103fc:	000780e7          	jalr	a5
   10400:	ff24e8e3          	bltu	s1,s2,103f0 <__libc_init_array+0x70>
   10404:	01813083          	ld	ra,24(sp)
   10408:	01013403          	ld	s0,16(sp)
   1040c:	00813483          	ld	s1,8(sp)
   10410:	00013903          	ld	s2,0(sp)
   10414:	02010113          	add	sp,sp,32
   10418:	00008067          	ret

000000000001041c <memset>:
   1041c:	00f00313          	li	t1,15
   10420:	00050713          	mv	a4,a0
   10424:	02c37a63          	bgeu	t1,a2,10458 <memset+0x3c>
   10428:	00f77793          	and	a5,a4,15
   1042c:	0a079063          	bnez	a5,104cc <memset+0xb0>
   10430:	06059e63          	bnez	a1,104ac <memset+0x90>
   10434:	ff067693          	and	a3,a2,-16
   10438:	00f67613          	and	a2,a2,15
   1043c:	00e686b3          	add	a3,a3,a4
   10440:	00b73023          	sd	a1,0(a4)
   10444:	00b73423          	sd	a1,8(a4)
   10448:	01070713          	add	a4,a4,16
   1044c:	fed76ae3          	bltu	a4,a3,10440 <memset+0x24>
   10450:	00061463          	bnez	a2,10458 <memset+0x3c>
   10454:	00008067          	ret
   10458:	40c306b3          	sub	a3,t1,a2
   1045c:	00269693          	sll	a3,a3,0x2
   10460:	00000297          	auipc	t0,0x0
   10464:	005686b3          	add	a3,a3,t0
   10468:	00c68067          	jr	12(a3)
   1046c:	00b70723          	sb	a1,14(a4)
   10470:	00b706a3          	sb	a1,13(a4)
   10474:	00b70623          	sb	a1,12(a4)
   10478:	00b705a3          	sb	a1,11(a4)
   1047c:	00b70523          	sb	a1,10(a4)
   10480:	00b704a3          	sb	a1,9(a4)
   10484:	00b70423          	sb	a1,8(a4)
   10488:	00b703a3          	sb	a1,7(a4)
   1048c:	00b70323          	sb	a1,6(a4)
   10490:	00b702a3          	sb	a1,5(a4)
   10494:	00b70223          	sb	a1,4(a4)
   10498:	00b701a3          	sb	a1,3(a4)
   1049c:	00b70123          	sb	a1,2(a4)
   104a0:	00b700a3          	sb	a1,1(a4)
   104a4:	00b70023          	sb	a1,0(a4)
   104a8:	00008067          	ret
   104ac:	0ff5f593          	zext.b	a1,a1
   104b0:	00859693          	sll	a3,a1,0x8
   104b4:	00d5e5b3          	or	a1,a1,a3
   104b8:	01059693          	sll	a3,a1,0x10
   104bc:	00d5e5b3          	or	a1,a1,a3
   104c0:	02059693          	sll	a3,a1,0x20
   104c4:	00d5e5b3          	or	a1,a1,a3
   104c8:	f6dff06f          	j	10434 <memset+0x18>
   104cc:	00279693          	sll	a3,a5,0x2
   104d0:	00000297          	auipc	t0,0x0
   104d4:	005686b3          	add	a3,a3,t0
   104d8:	00008293          	mv	t0,ra
   104dc:	f98680e7          	jalr	-104(a3)
   104e0:	00028093          	mv	ra,t0
   104e4:	ff078793          	add	a5,a5,-16
   104e8:	40f70733          	sub	a4,a4,a5
   104ec:	00f60633          	add	a2,a2,a5
   104f0:	f6c374e3          	bgeu	t1,a2,10458 <memset+0x3c>
   104f4:	f3dff06f          	j	10430 <memset+0x14>

00000000000104f8 <__call_exitprocs>:
   104f8:	fb010113          	add	sp,sp,-80
   104fc:	03413023          	sd	s4,32(sp)
   10500:	f481ba03          	ld	s4,-184(gp) # 11ed8 <_global_impure_ptr>
   10504:	03213823          	sd	s2,48(sp)
   10508:	04113423          	sd	ra,72(sp)
   1050c:	1f8a3903          	ld	s2,504(s4)
   10510:	04813023          	sd	s0,64(sp)
   10514:	02913c23          	sd	s1,56(sp)
   10518:	03313423          	sd	s3,40(sp)
   1051c:	01513c23          	sd	s5,24(sp)
   10520:	01613823          	sd	s6,16(sp)
   10524:	01713423          	sd	s7,8(sp)
   10528:	01813023          	sd	s8,0(sp)
   1052c:	04090063          	beqz	s2,1056c <__call_exitprocs+0x74>
   10530:	00050b13          	mv	s6,a0
   10534:	00058b93          	mv	s7,a1
   10538:	00100a93          	li	s5,1
   1053c:	fff00993          	li	s3,-1
   10540:	00892483          	lw	s1,8(s2)
   10544:	fff4841b          	addw	s0,s1,-1
   10548:	02044263          	bltz	s0,1056c <__call_exitprocs+0x74>
   1054c:	00349493          	sll	s1,s1,0x3
   10550:	009904b3          	add	s1,s2,s1
   10554:	040b8463          	beqz	s7,1059c <__call_exitprocs+0xa4>
   10558:	2084b783          	ld	a5,520(s1)
   1055c:	05778063          	beq	a5,s7,1059c <__call_exitprocs+0xa4>
   10560:	fff4041b          	addw	s0,s0,-1
   10564:	ff848493          	add	s1,s1,-8
   10568:	ff3416e3          	bne	s0,s3,10554 <__call_exitprocs+0x5c>
   1056c:	04813083          	ld	ra,72(sp)
   10570:	04013403          	ld	s0,64(sp)
   10574:	03813483          	ld	s1,56(sp)
   10578:	03013903          	ld	s2,48(sp)
   1057c:	02813983          	ld	s3,40(sp)
   10580:	02013a03          	ld	s4,32(sp)
   10584:	01813a83          	ld	s5,24(sp)
   10588:	01013b03          	ld	s6,16(sp)
   1058c:	00813b83          	ld	s7,8(sp)
   10590:	00013c03          	ld	s8,0(sp)
   10594:	05010113          	add	sp,sp,80
   10598:	00008067          	ret
   1059c:	00892783          	lw	a5,8(s2)
   105a0:	0084b703          	ld	a4,8(s1)
   105a4:	fff7879b          	addw	a5,a5,-1
   105a8:	06878263          	beq	a5,s0,1060c <__call_exitprocs+0x114>
   105ac:	0004b423          	sd	zero,8(s1)
   105b0:	fa0708e3          	beqz	a4,10560 <__call_exitprocs+0x68>
   105b4:	31092783          	lw	a5,784(s2)
   105b8:	008a96bb          	sllw	a3,s5,s0
   105bc:	00892c03          	lw	s8,8(s2)
   105c0:	00d7f7b3          	and	a5,a5,a3
   105c4:	0007879b          	sext.w	a5,a5
   105c8:	02079263          	bnez	a5,105ec <__call_exitprocs+0xf4>
   105cc:	000700e7          	jalr	a4
   105d0:	00892703          	lw	a4,8(s2)
   105d4:	1f8a3783          	ld	a5,504(s4)
   105d8:	01871463          	bne	a4,s8,105e0 <__call_exitprocs+0xe8>
   105dc:	f92782e3          	beq	a5,s2,10560 <__call_exitprocs+0x68>
   105e0:	f80786e3          	beqz	a5,1056c <__call_exitprocs+0x74>
   105e4:	00078913          	mv	s2,a5
   105e8:	f59ff06f          	j	10540 <__call_exitprocs+0x48>
   105ec:	31492783          	lw	a5,788(s2)
   105f0:	1084b583          	ld	a1,264(s1)
   105f4:	00d7f7b3          	and	a5,a5,a3
   105f8:	0007879b          	sext.w	a5,a5
   105fc:	00079c63          	bnez	a5,10614 <__call_exitprocs+0x11c>
   10600:	000b0513          	mv	a0,s6
   10604:	000700e7          	jalr	a4
   10608:	fc9ff06f          	j	105d0 <__call_exitprocs+0xd8>
   1060c:	00892423          	sw	s0,8(s2)
   10610:	fa1ff06f          	j	105b0 <__call_exitprocs+0xb8>
   10614:	00058513          	mv	a0,a1
   10618:	000700e7          	jalr	a4
   1061c:	fb5ff06f          	j	105d0 <__call_exitprocs+0xd8>

0000000000010620 <__libc_fini_array>:
   10620:	fe010113          	add	sp,sp,-32
   10624:	00813823          	sd	s0,16(sp)
   10628:	000117b7          	lui	a5,0x11
   1062c:	00011437          	lui	s0,0x11
   10630:	78878793          	add	a5,a5,1928 # 11788 <__do_global_dtors_aux_fini_array_entry>
   10634:	79040413          	add	s0,s0,1936 # 11790 <impure_data>
   10638:	40f40433          	sub	s0,s0,a5
   1063c:	00913423          	sd	s1,8(sp)
   10640:	00113c23          	sd	ra,24(sp)
   10644:	40345493          	sra	s1,s0,0x3
   10648:	02048063          	beqz	s1,10668 <__libc_fini_array+0x48>
   1064c:	ff840413          	add	s0,s0,-8
   10650:	00f40433          	add	s0,s0,a5
   10654:	00043783          	ld	a5,0(s0)
   10658:	fff48493          	add	s1,s1,-1
   1065c:	ff840413          	add	s0,s0,-8
   10660:	000780e7          	jalr	a5
   10664:	fe0498e3          	bnez	s1,10654 <__libc_fini_array+0x34>
   10668:	01813083          	ld	ra,24(sp)
   1066c:	01013403          	ld	s0,16(sp)
   10670:	00813483          	ld	s1,8(sp)
   10674:	02010113          	add	sp,sp,32
   10678:	00008067          	ret

000000000001067c <atexit>:
   1067c:	00050593          	mv	a1,a0
   10680:	00000693          	li	a3,0
   10684:	00000613          	li	a2,0
   10688:	00000513          	li	a0,0
   1068c:	0040006f          	j	10690 <__register_exitproc>

0000000000010690 <__register_exitproc>:
   10690:	f481b703          	ld	a4,-184(gp) # 11ed8 <_global_impure_ptr>
   10694:	1f873783          	ld	a5,504(a4)
   10698:	06078063          	beqz	a5,106f8 <__register_exitproc+0x68>
   1069c:	0087a703          	lw	a4,8(a5)
   106a0:	01f00813          	li	a6,31
   106a4:	08e84663          	blt	a6,a4,10730 <__register_exitproc+0xa0>
   106a8:	02050863          	beqz	a0,106d8 <__register_exitproc+0x48>
   106ac:	00371813          	sll	a6,a4,0x3
   106b0:	01078833          	add	a6,a5,a6
   106b4:	10c83823          	sd	a2,272(a6)
   106b8:	3107a883          	lw	a7,784(a5)
   106bc:	00100613          	li	a2,1
   106c0:	00e6163b          	sllw	a2,a2,a4
   106c4:	00c8e8b3          	or	a7,a7,a2
   106c8:	3117a823          	sw	a7,784(a5)
   106cc:	20d83823          	sd	a3,528(a6)
   106d0:	00200693          	li	a3,2
   106d4:	02d50863          	beq	a0,a3,10704 <__register_exitproc+0x74>
   106d8:	00270693          	add	a3,a4,2
   106dc:	00369693          	sll	a3,a3,0x3
   106e0:	0017071b          	addw	a4,a4,1
   106e4:	00e7a423          	sw	a4,8(a5)
   106e8:	00d787b3          	add	a5,a5,a3
   106ec:	00b7b023          	sd	a1,0(a5)
   106f0:	00000513          	li	a0,0
   106f4:	00008067          	ret
   106f8:	20070793          	add	a5,a4,512
   106fc:	1ef73c23          	sd	a5,504(a4)
   10700:	f9dff06f          	j	1069c <__register_exitproc+0xc>
   10704:	3147a683          	lw	a3,788(a5)
   10708:	00000513          	li	a0,0
   1070c:	00c6e6b3          	or	a3,a3,a2
   10710:	30d7aa23          	sw	a3,788(a5)
   10714:	00270693          	add	a3,a4,2
   10718:	00369693          	sll	a3,a3,0x3
   1071c:	0017071b          	addw	a4,a4,1
   10720:	00e7a423          	sw	a4,8(a5)
   10724:	00d787b3          	add	a5,a5,a3
   10728:	00b7b023          	sd	a1,0(a5)
   1072c:	00008067          	ret
   10730:	fff00513          	li	a0,-1
   10734:	00008067          	ret

0000000000010738 <_exit>:
   10738:	05d00893          	li	a7,93
   1073c:	00000073          	ecall
   10740:	00054463          	bltz	a0,10748 <_exit+0x10>
   10744:	0000006f          	j	10744 <_exit+0xc>
   10748:	ff010113          	add	sp,sp,-16
   1074c:	00813023          	sd	s0,0(sp)
   10750:	00050413          	mv	s0,a0
   10754:	00113423          	sd	ra,8(sp)
   10758:	4080043b          	negw	s0,s0
   1075c:	00c000ef          	jal	10768 <__errno>
   10760:	00852023          	sw	s0,0(a0)
   10764:	0000006f          	j	10764 <_exit+0x2c>

0000000000010768 <__errno>:
   10768:	f581b503          	ld	a0,-168(gp) # 11ee8 <_impure_ptr>
   1076c:	00008067          	ret
