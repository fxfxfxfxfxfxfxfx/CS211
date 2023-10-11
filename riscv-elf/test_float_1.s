
../riscv-elf/test_float_1.riscv:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	3c8000ef          	jal	104c4 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11ea8 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	5f0000ef          	jal	10704 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	5ec50513          	add	a0,a0,1516 # 105ec <__libc_fini_array>
   10128:	5200006f          	j	10648 <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00002197          	auipc	gp,0x2
   10134:	e3018193          	add	gp,gp,-464 # 11f60 <__global_pointer$>
   10138:	f6018513          	add	a0,gp,-160 # 11ec0 <completed.1>
   1013c:	f9818613          	add	a2,gp,-104 # 11ef8 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	2a0000ef          	jal	103e8 <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	4fc50513          	add	a0,a0,1276 # 10648 <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	49450513          	add	a0,a0,1172 # 105ec <__libc_fini_array>
   10160:	4e8000ef          	jal	10648 <atexit>
   10164:	1e8000ef          	jal	1034c <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	add	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	06c000ef          	jal	101e0 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	add	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11ec0 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	74050513          	add	a0,a0,1856 # 11740 <__EH_FRAME_BEGIN__>
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11ec0 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	add	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	f6818593          	add	a1,gp,-152 # 11ec8 <object.0>
   101d0:	74050513          	add	a0,a0,1856 # 11740 <__EH_FRAME_BEGIN__>
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <main>:
   101e0:	fe010113          	add	sp,sp,-32
   101e4:	00113c23          	sd	ra,24(sp)
   101e8:	00813823          	sd	s0,16(sp)
   101ec:	02010413          	add	s0,sp,32
   101f0:	000107b7          	lui	a5,0x10
   101f4:	73c7a787          	flw	fa5,1852(a5) # 1073c <__errno+0x8>
   101f8:	fef42627          	fsw	fa5,-20(s0)
   101fc:	fec42507          	flw	fa0,-20(s0)
   10200:	124000ef          	jal	10324 <print_f>
   10204:	09c000ef          	jal	102a0 <exit_proc>
   10208:	00000793          	li	a5,0
   1020c:	00078513          	mv	a0,a5
   10210:	01813083          	ld	ra,24(sp)
   10214:	01013403          	ld	s0,16(sp)
   10218:	02010113          	add	sp,sp,32
   1021c:	00008067          	ret

0000000000010220 <print_d>:
   10220:	fe010113          	add	sp,sp,-32
   10224:	00813c23          	sd	s0,24(sp)
   10228:	02010413          	add	s0,sp,32
   1022c:	00050793          	mv	a5,a0
   10230:	fef42623          	sw	a5,-20(s0)
   10234:	00200893          	li	a7,2
   10238:	00000073          	ecall
   1023c:	00000013          	nop
   10240:	01813403          	ld	s0,24(sp)
   10244:	02010113          	add	sp,sp,32
   10248:	00008067          	ret

000000000001024c <print_s>:
   1024c:	fe010113          	add	sp,sp,-32
   10250:	00813c23          	sd	s0,24(sp)
   10254:	02010413          	add	s0,sp,32
   10258:	fea43423          	sd	a0,-24(s0)
   1025c:	00000893          	li	a7,0
   10260:	00000073          	ecall
   10264:	00000013          	nop
   10268:	01813403          	ld	s0,24(sp)
   1026c:	02010113          	add	sp,sp,32
   10270:	00008067          	ret

0000000000010274 <print_c>:
   10274:	fe010113          	add	sp,sp,-32
   10278:	00813c23          	sd	s0,24(sp)
   1027c:	02010413          	add	s0,sp,32
   10280:	00050793          	mv	a5,a0
   10284:	fef407a3          	sb	a5,-17(s0)
   10288:	00100893          	li	a7,1
   1028c:	00000073          	ecall
   10290:	00000013          	nop
   10294:	01813403          	ld	s0,24(sp)
   10298:	02010113          	add	sp,sp,32
   1029c:	00008067          	ret

00000000000102a0 <exit_proc>:
   102a0:	ff010113          	add	sp,sp,-16
   102a4:	00813423          	sd	s0,8(sp)
   102a8:	01010413          	add	s0,sp,16
   102ac:	00300893          	li	a7,3
   102b0:	00000073          	ecall
   102b4:	00000013          	nop
   102b8:	00813403          	ld	s0,8(sp)
   102bc:	01010113          	add	sp,sp,16
   102c0:	00008067          	ret

00000000000102c4 <read_char>:
   102c4:	fe010113          	add	sp,sp,-32
   102c8:	00813c23          	sd	s0,24(sp)
   102cc:	02010413          	add	s0,sp,32
   102d0:	00400893          	li	a7,4
   102d4:	00000073          	ecall
   102d8:	00050793          	mv	a5,a0
   102dc:	fef407a3          	sb	a5,-17(s0)
   102e0:	fef44783          	lbu	a5,-17(s0)
   102e4:	00078513          	mv	a0,a5
   102e8:	01813403          	ld	s0,24(sp)
   102ec:	02010113          	add	sp,sp,32
   102f0:	00008067          	ret

00000000000102f4 <read_num>:
   102f4:	fe010113          	add	sp,sp,-32
   102f8:	00813c23          	sd	s0,24(sp)
   102fc:	02010413          	add	s0,sp,32
   10300:	00500893          	li	a7,5
   10304:	00000073          	ecall
   10308:	00050793          	mv	a5,a0
   1030c:	fef43423          	sd	a5,-24(s0)
   10310:	fe843783          	ld	a5,-24(s0)
   10314:	00078513          	mv	a0,a5
   10318:	01813403          	ld	s0,24(sp)
   1031c:	02010113          	add	sp,sp,32
   10320:	00008067          	ret

0000000000010324 <print_f>:
   10324:	fe010113          	add	sp,sp,-32
   10328:	00813c23          	sd	s0,24(sp)
   1032c:	02010413          	add	s0,sp,32
   10330:	fea42627          	fsw	fa0,-20(s0)
   10334:	00600893          	li	a7,6
   10338:	00000073          	ecall
   1033c:	00000013          	nop
   10340:	01813403          	ld	s0,24(sp)
   10344:	02010113          	add	sp,sp,32
   10348:	00008067          	ret

000000000001034c <__libc_init_array>:
   1034c:	fe010113          	add	sp,sp,-32
   10350:	00813823          	sd	s0,16(sp)
   10354:	000117b7          	lui	a5,0x11
   10358:	00011437          	lui	s0,0x11
   1035c:	01213023          	sd	s2,0(sp)
   10360:	74478793          	add	a5,a5,1860 # 11744 <__preinit_array_end>
   10364:	74440713          	add	a4,s0,1860 # 11744 <__preinit_array_end>
   10368:	00113c23          	sd	ra,24(sp)
   1036c:	00913423          	sd	s1,8(sp)
   10370:	40e78933          	sub	s2,a5,a4
   10374:	02e78263          	beq	a5,a4,10398 <__libc_init_array+0x4c>
   10378:	40395913          	sra	s2,s2,0x3
   1037c:	74440413          	add	s0,s0,1860
   10380:	00000493          	li	s1,0
   10384:	00043783          	ld	a5,0(s0)
   10388:	00148493          	add	s1,s1,1
   1038c:	00840413          	add	s0,s0,8
   10390:	000780e7          	jalr	a5
   10394:	ff24e8e3          	bltu	s1,s2,10384 <__libc_init_array+0x38>
   10398:	00011437          	lui	s0,0x11
   1039c:	000117b7          	lui	a5,0x11
   103a0:	75878793          	add	a5,a5,1880 # 11758 <__do_global_dtors_aux_fini_array_entry>
   103a4:	74840713          	add	a4,s0,1864 # 11748 <__init_array_start>
   103a8:	40e78933          	sub	s2,a5,a4
   103ac:	40395913          	sra	s2,s2,0x3
   103b0:	02e78063          	beq	a5,a4,103d0 <__libc_init_array+0x84>
   103b4:	74840413          	add	s0,s0,1864
   103b8:	00000493          	li	s1,0
   103bc:	00043783          	ld	a5,0(s0)
   103c0:	00148493          	add	s1,s1,1
   103c4:	00840413          	add	s0,s0,8
   103c8:	000780e7          	jalr	a5
   103cc:	ff24e8e3          	bltu	s1,s2,103bc <__libc_init_array+0x70>
   103d0:	01813083          	ld	ra,24(sp)
   103d4:	01013403          	ld	s0,16(sp)
   103d8:	00813483          	ld	s1,8(sp)
   103dc:	00013903          	ld	s2,0(sp)
   103e0:	02010113          	add	sp,sp,32
   103e4:	00008067          	ret

00000000000103e8 <memset>:
   103e8:	00f00313          	li	t1,15
   103ec:	00050713          	mv	a4,a0
   103f0:	02c37a63          	bgeu	t1,a2,10424 <memset+0x3c>
   103f4:	00f77793          	and	a5,a4,15
   103f8:	0a079063          	bnez	a5,10498 <memset+0xb0>
   103fc:	06059e63          	bnez	a1,10478 <memset+0x90>
   10400:	ff067693          	and	a3,a2,-16
   10404:	00f67613          	and	a2,a2,15
   10408:	00e686b3          	add	a3,a3,a4
   1040c:	00b73023          	sd	a1,0(a4)
   10410:	00b73423          	sd	a1,8(a4)
   10414:	01070713          	add	a4,a4,16
   10418:	fed76ae3          	bltu	a4,a3,1040c <memset+0x24>
   1041c:	00061463          	bnez	a2,10424 <memset+0x3c>
   10420:	00008067          	ret
   10424:	40c306b3          	sub	a3,t1,a2
   10428:	00269693          	sll	a3,a3,0x2
   1042c:	00000297          	auipc	t0,0x0
   10430:	005686b3          	add	a3,a3,t0
   10434:	00c68067          	jr	12(a3)
   10438:	00b70723          	sb	a1,14(a4)
   1043c:	00b706a3          	sb	a1,13(a4)
   10440:	00b70623          	sb	a1,12(a4)
   10444:	00b705a3          	sb	a1,11(a4)
   10448:	00b70523          	sb	a1,10(a4)
   1044c:	00b704a3          	sb	a1,9(a4)
   10450:	00b70423          	sb	a1,8(a4)
   10454:	00b703a3          	sb	a1,7(a4)
   10458:	00b70323          	sb	a1,6(a4)
   1045c:	00b702a3          	sb	a1,5(a4)
   10460:	00b70223          	sb	a1,4(a4)
   10464:	00b701a3          	sb	a1,3(a4)
   10468:	00b70123          	sb	a1,2(a4)
   1046c:	00b700a3          	sb	a1,1(a4)
   10470:	00b70023          	sb	a1,0(a4)
   10474:	00008067          	ret
   10478:	0ff5f593          	zext.b	a1,a1
   1047c:	00859693          	sll	a3,a1,0x8
   10480:	00d5e5b3          	or	a1,a1,a3
   10484:	01059693          	sll	a3,a1,0x10
   10488:	00d5e5b3          	or	a1,a1,a3
   1048c:	02059693          	sll	a3,a1,0x20
   10490:	00d5e5b3          	or	a1,a1,a3
   10494:	f6dff06f          	j	10400 <memset+0x18>
   10498:	00279693          	sll	a3,a5,0x2
   1049c:	00000297          	auipc	t0,0x0
   104a0:	005686b3          	add	a3,a3,t0
   104a4:	00008293          	mv	t0,ra
   104a8:	f98680e7          	jalr	-104(a3)
   104ac:	00028093          	mv	ra,t0
   104b0:	ff078793          	add	a5,a5,-16
   104b4:	40f70733          	sub	a4,a4,a5
   104b8:	00f60633          	add	a2,a2,a5
   104bc:	f6c374e3          	bgeu	t1,a2,10424 <memset+0x3c>
   104c0:	f3dff06f          	j	103fc <memset+0x14>

00000000000104c4 <__call_exitprocs>:
   104c4:	fb010113          	add	sp,sp,-80
   104c8:	03413023          	sd	s4,32(sp)
   104cc:	f481ba03          	ld	s4,-184(gp) # 11ea8 <_global_impure_ptr>
   104d0:	03213823          	sd	s2,48(sp)
   104d4:	04113423          	sd	ra,72(sp)
   104d8:	1f8a3903          	ld	s2,504(s4)
   104dc:	04813023          	sd	s0,64(sp)
   104e0:	02913c23          	sd	s1,56(sp)
   104e4:	03313423          	sd	s3,40(sp)
   104e8:	01513c23          	sd	s5,24(sp)
   104ec:	01613823          	sd	s6,16(sp)
   104f0:	01713423          	sd	s7,8(sp)
   104f4:	01813023          	sd	s8,0(sp)
   104f8:	04090063          	beqz	s2,10538 <__call_exitprocs+0x74>
   104fc:	00050b13          	mv	s6,a0
   10500:	00058b93          	mv	s7,a1
   10504:	00100a93          	li	s5,1
   10508:	fff00993          	li	s3,-1
   1050c:	00892483          	lw	s1,8(s2)
   10510:	fff4841b          	addw	s0,s1,-1
   10514:	02044263          	bltz	s0,10538 <__call_exitprocs+0x74>
   10518:	00349493          	sll	s1,s1,0x3
   1051c:	009904b3          	add	s1,s2,s1
   10520:	040b8463          	beqz	s7,10568 <__call_exitprocs+0xa4>
   10524:	2084b783          	ld	a5,520(s1)
   10528:	05778063          	beq	a5,s7,10568 <__call_exitprocs+0xa4>
   1052c:	fff4041b          	addw	s0,s0,-1
   10530:	ff848493          	add	s1,s1,-8
   10534:	ff3416e3          	bne	s0,s3,10520 <__call_exitprocs+0x5c>
   10538:	04813083          	ld	ra,72(sp)
   1053c:	04013403          	ld	s0,64(sp)
   10540:	03813483          	ld	s1,56(sp)
   10544:	03013903          	ld	s2,48(sp)
   10548:	02813983          	ld	s3,40(sp)
   1054c:	02013a03          	ld	s4,32(sp)
   10550:	01813a83          	ld	s5,24(sp)
   10554:	01013b03          	ld	s6,16(sp)
   10558:	00813b83          	ld	s7,8(sp)
   1055c:	00013c03          	ld	s8,0(sp)
   10560:	05010113          	add	sp,sp,80
   10564:	00008067          	ret
   10568:	00892783          	lw	a5,8(s2)
   1056c:	0084b703          	ld	a4,8(s1)
   10570:	fff7879b          	addw	a5,a5,-1
   10574:	06878263          	beq	a5,s0,105d8 <__call_exitprocs+0x114>
   10578:	0004b423          	sd	zero,8(s1)
   1057c:	fa0708e3          	beqz	a4,1052c <__call_exitprocs+0x68>
   10580:	31092783          	lw	a5,784(s2)
   10584:	008a96bb          	sllw	a3,s5,s0
   10588:	00892c03          	lw	s8,8(s2)
   1058c:	00d7f7b3          	and	a5,a5,a3
   10590:	0007879b          	sext.w	a5,a5
   10594:	02079263          	bnez	a5,105b8 <__call_exitprocs+0xf4>
   10598:	000700e7          	jalr	a4
   1059c:	00892703          	lw	a4,8(s2)
   105a0:	1f8a3783          	ld	a5,504(s4)
   105a4:	01871463          	bne	a4,s8,105ac <__call_exitprocs+0xe8>
   105a8:	f92782e3          	beq	a5,s2,1052c <__call_exitprocs+0x68>
   105ac:	f80786e3          	beqz	a5,10538 <__call_exitprocs+0x74>
   105b0:	00078913          	mv	s2,a5
   105b4:	f59ff06f          	j	1050c <__call_exitprocs+0x48>
   105b8:	31492783          	lw	a5,788(s2)
   105bc:	1084b583          	ld	a1,264(s1)
   105c0:	00d7f7b3          	and	a5,a5,a3
   105c4:	0007879b          	sext.w	a5,a5
   105c8:	00079c63          	bnez	a5,105e0 <__call_exitprocs+0x11c>
   105cc:	000b0513          	mv	a0,s6
   105d0:	000700e7          	jalr	a4
   105d4:	fc9ff06f          	j	1059c <__call_exitprocs+0xd8>
   105d8:	00892423          	sw	s0,8(s2)
   105dc:	fa1ff06f          	j	1057c <__call_exitprocs+0xb8>
   105e0:	00058513          	mv	a0,a1
   105e4:	000700e7          	jalr	a4
   105e8:	fb5ff06f          	j	1059c <__call_exitprocs+0xd8>

00000000000105ec <__libc_fini_array>:
   105ec:	fe010113          	add	sp,sp,-32
   105f0:	00813823          	sd	s0,16(sp)
   105f4:	000117b7          	lui	a5,0x11
   105f8:	00011437          	lui	s0,0x11
   105fc:	75878793          	add	a5,a5,1880 # 11758 <__do_global_dtors_aux_fini_array_entry>
   10600:	76040413          	add	s0,s0,1888 # 11760 <impure_data>
   10604:	40f40433          	sub	s0,s0,a5
   10608:	00913423          	sd	s1,8(sp)
   1060c:	00113c23          	sd	ra,24(sp)
   10610:	40345493          	sra	s1,s0,0x3
   10614:	02048063          	beqz	s1,10634 <__libc_fini_array+0x48>
   10618:	ff840413          	add	s0,s0,-8
   1061c:	00f40433          	add	s0,s0,a5
   10620:	00043783          	ld	a5,0(s0)
   10624:	fff48493          	add	s1,s1,-1
   10628:	ff840413          	add	s0,s0,-8
   1062c:	000780e7          	jalr	a5
   10630:	fe0498e3          	bnez	s1,10620 <__libc_fini_array+0x34>
   10634:	01813083          	ld	ra,24(sp)
   10638:	01013403          	ld	s0,16(sp)
   1063c:	00813483          	ld	s1,8(sp)
   10640:	02010113          	add	sp,sp,32
   10644:	00008067          	ret

0000000000010648 <atexit>:
   10648:	00050593          	mv	a1,a0
   1064c:	00000693          	li	a3,0
   10650:	00000613          	li	a2,0
   10654:	00000513          	li	a0,0
   10658:	0040006f          	j	1065c <__register_exitproc>

000000000001065c <__register_exitproc>:
   1065c:	f481b703          	ld	a4,-184(gp) # 11ea8 <_global_impure_ptr>
   10660:	1f873783          	ld	a5,504(a4)
   10664:	06078063          	beqz	a5,106c4 <__register_exitproc+0x68>
   10668:	0087a703          	lw	a4,8(a5)
   1066c:	01f00813          	li	a6,31
   10670:	08e84663          	blt	a6,a4,106fc <__register_exitproc+0xa0>
   10674:	02050863          	beqz	a0,106a4 <__register_exitproc+0x48>
   10678:	00371813          	sll	a6,a4,0x3
   1067c:	01078833          	add	a6,a5,a6
   10680:	10c83823          	sd	a2,272(a6)
   10684:	3107a883          	lw	a7,784(a5)
   10688:	00100613          	li	a2,1
   1068c:	00e6163b          	sllw	a2,a2,a4
   10690:	00c8e8b3          	or	a7,a7,a2
   10694:	3117a823          	sw	a7,784(a5)
   10698:	20d83823          	sd	a3,528(a6)
   1069c:	00200693          	li	a3,2
   106a0:	02d50863          	beq	a0,a3,106d0 <__register_exitproc+0x74>
   106a4:	00270693          	add	a3,a4,2
   106a8:	00369693          	sll	a3,a3,0x3
   106ac:	0017071b          	addw	a4,a4,1
   106b0:	00e7a423          	sw	a4,8(a5)
   106b4:	00d787b3          	add	a5,a5,a3
   106b8:	00b7b023          	sd	a1,0(a5)
   106bc:	00000513          	li	a0,0
   106c0:	00008067          	ret
   106c4:	20070793          	add	a5,a4,512
   106c8:	1ef73c23          	sd	a5,504(a4)
   106cc:	f9dff06f          	j	10668 <__register_exitproc+0xc>
   106d0:	3147a683          	lw	a3,788(a5)
   106d4:	00000513          	li	a0,0
   106d8:	00c6e6b3          	or	a3,a3,a2
   106dc:	30d7aa23          	sw	a3,788(a5)
   106e0:	00270693          	add	a3,a4,2
   106e4:	00369693          	sll	a3,a3,0x3
   106e8:	0017071b          	addw	a4,a4,1
   106ec:	00e7a423          	sw	a4,8(a5)
   106f0:	00d787b3          	add	a5,a5,a3
   106f4:	00b7b023          	sd	a1,0(a5)
   106f8:	00008067          	ret
   106fc:	fff00513          	li	a0,-1
   10700:	00008067          	ret

0000000000010704 <_exit>:
   10704:	05d00893          	li	a7,93
   10708:	00000073          	ecall
   1070c:	00054463          	bltz	a0,10714 <_exit+0x10>
   10710:	0000006f          	j	10710 <_exit+0xc>
   10714:	ff010113          	add	sp,sp,-16
   10718:	00813023          	sd	s0,0(sp)
   1071c:	00050413          	mv	s0,a0
   10720:	00113423          	sd	ra,8(sp)
   10724:	4080043b          	negw	s0,s0
   10728:	00c000ef          	jal	10734 <__errno>
   1072c:	00852023          	sw	s0,0(a0)
   10730:	0000006f          	j	10730 <_exit+0x2c>

0000000000010734 <__errno>:
   10734:	f581b503          	ld	a0,-168(gp) # 11eb8 <_impure_ptr>
   10738:	00008067          	ret
