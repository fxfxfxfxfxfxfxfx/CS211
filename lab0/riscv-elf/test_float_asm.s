
../riscv-elf/test_float_asm.riscv:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	3ec000ef          	jal	104e8 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11ed0 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	614000ef          	jal	10728 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	61050513          	add	a0,a0,1552 # 10610 <__libc_fini_array>
   10128:	5440006f          	j	1066c <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00002197          	auipc	gp,0x2
   10134:	e5818193          	add	gp,gp,-424 # 11f88 <__global_pointer$>
   10138:	f6018513          	add	a0,gp,-160 # 11ee8 <completed.1>
   1013c:	f9818613          	add	a2,gp,-104 # 11f20 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	2c4000ef          	jal	1040c <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	52050513          	add	a0,a0,1312 # 1066c <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	4b850513          	add	a0,a0,1208 # 10610 <__libc_fini_array>
   10160:	50c000ef          	jal	1066c <atexit>
   10164:	20c000ef          	jal	10370 <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	add	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	06c000ef          	jal	101e0 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	add	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11ee8 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	76850513          	add	a0,a0,1896 # 11768 <__EH_FRAME_BEGIN__>
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11ee8 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	add	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	f6818593          	add	a1,gp,-152 # 11ef0 <object.0>
   101d0:	76850513          	add	a0,a0,1896 # 11768 <__EH_FRAME_BEGIN__>
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <main>:
   101e0:	fe010113          	add	sp,sp,-32
   101e4:	00113c23          	sd	ra,24(sp)
   101e8:	00813823          	sd	s0,16(sp)
   101ec:	02010413          	add	s0,sp,32
   101f0:	000107b7          	lui	a5,0x10
   101f4:	7607a787          	flw	fa5,1888(a5) # 10760 <__errno+0x8>
   101f8:	fef42627          	fsw	fa5,-20(s0)
   101fc:	000107b7          	lui	a5,0x10
   10200:	7647a787          	flw	fa5,1892(a5) # 10764 <__errno+0xc>
   10204:	fef42427          	fsw	fa5,-24(s0)
   10208:	fec42507          	flw	fa0,-20(s0)
   1020c:	13c000ef          	jal	10348 <print_f>
   10210:	00a00513          	li	a0,10
   10214:	084000ef          	jal	10298 <print_c>
   10218:	fe842507          	flw	fa0,-24(s0)
   1021c:	12c000ef          	jal	10348 <print_f>
   10220:	00a00513          	li	a0,10
   10224:	074000ef          	jal	10298 <print_c>
   10228:	09c000ef          	jal	102c4 <exit_proc>
   1022c:	00000793          	li	a5,0
   10230:	00078513          	mv	a0,a5
   10234:	01813083          	ld	ra,24(sp)
   10238:	01013403          	ld	s0,16(sp)
   1023c:	02010113          	add	sp,sp,32
   10240:	00008067          	ret

0000000000010244 <print_d>:
   10244:	fe010113          	add	sp,sp,-32
   10248:	00813c23          	sd	s0,24(sp)
   1024c:	02010413          	add	s0,sp,32
   10250:	00050793          	mv	a5,a0
   10254:	fef42623          	sw	a5,-20(s0)
   10258:	00200893          	li	a7,2
   1025c:	00000073          	ecall
   10260:	00000013          	nop
   10264:	01813403          	ld	s0,24(sp)
   10268:	02010113          	add	sp,sp,32
   1026c:	00008067          	ret

0000000000010270 <print_s>:
   10270:	fe010113          	add	sp,sp,-32
   10274:	00813c23          	sd	s0,24(sp)
   10278:	02010413          	add	s0,sp,32
   1027c:	fea43423          	sd	a0,-24(s0)
   10280:	00000893          	li	a7,0
   10284:	00000073          	ecall
   10288:	00000013          	nop
   1028c:	01813403          	ld	s0,24(sp)
   10290:	02010113          	add	sp,sp,32
   10294:	00008067          	ret

0000000000010298 <print_c>:
   10298:	fe010113          	add	sp,sp,-32
   1029c:	00813c23          	sd	s0,24(sp)
   102a0:	02010413          	add	s0,sp,32
   102a4:	00050793          	mv	a5,a0
   102a8:	fef407a3          	sb	a5,-17(s0)
   102ac:	00100893          	li	a7,1
   102b0:	00000073          	ecall
   102b4:	00000013          	nop
   102b8:	01813403          	ld	s0,24(sp)
   102bc:	02010113          	add	sp,sp,32
   102c0:	00008067          	ret

00000000000102c4 <exit_proc>:
   102c4:	ff010113          	add	sp,sp,-16
   102c8:	00813423          	sd	s0,8(sp)
   102cc:	01010413          	add	s0,sp,16
   102d0:	00300893          	li	a7,3
   102d4:	00000073          	ecall
   102d8:	00000013          	nop
   102dc:	00813403          	ld	s0,8(sp)
   102e0:	01010113          	add	sp,sp,16
   102e4:	00008067          	ret

00000000000102e8 <read_char>:
   102e8:	fe010113          	add	sp,sp,-32
   102ec:	00813c23          	sd	s0,24(sp)
   102f0:	02010413          	add	s0,sp,32
   102f4:	00400893          	li	a7,4
   102f8:	00000073          	ecall
   102fc:	00050793          	mv	a5,a0
   10300:	fef407a3          	sb	a5,-17(s0)
   10304:	fef44783          	lbu	a5,-17(s0)
   10308:	00078513          	mv	a0,a5
   1030c:	01813403          	ld	s0,24(sp)
   10310:	02010113          	add	sp,sp,32
   10314:	00008067          	ret

0000000000010318 <read_num>:
   10318:	fe010113          	add	sp,sp,-32
   1031c:	00813c23          	sd	s0,24(sp)
   10320:	02010413          	add	s0,sp,32
   10324:	00500893          	li	a7,5
   10328:	00000073          	ecall
   1032c:	00050793          	mv	a5,a0
   10330:	fef43423          	sd	a5,-24(s0)
   10334:	fe843783          	ld	a5,-24(s0)
   10338:	00078513          	mv	a0,a5
   1033c:	01813403          	ld	s0,24(sp)
   10340:	02010113          	add	sp,sp,32
   10344:	00008067          	ret

0000000000010348 <print_f>:
   10348:	fe010113          	add	sp,sp,-32
   1034c:	00813c23          	sd	s0,24(sp)
   10350:	02010413          	add	s0,sp,32
   10354:	fea42627          	fsw	fa0,-20(s0)
   10358:	00600893          	li	a7,6
   1035c:	00000073          	ecall
   10360:	00000013          	nop
   10364:	01813403          	ld	s0,24(sp)
   10368:	02010113          	add	sp,sp,32
   1036c:	00008067          	ret

0000000000010370 <__libc_init_array>:
   10370:	fe010113          	add	sp,sp,-32
   10374:	00813823          	sd	s0,16(sp)
   10378:	000117b7          	lui	a5,0x11
   1037c:	00011437          	lui	s0,0x11
   10380:	01213023          	sd	s2,0(sp)
   10384:	76c78793          	add	a5,a5,1900 # 1176c <__preinit_array_end>
   10388:	76c40713          	add	a4,s0,1900 # 1176c <__preinit_array_end>
   1038c:	00113c23          	sd	ra,24(sp)
   10390:	00913423          	sd	s1,8(sp)
   10394:	40e78933          	sub	s2,a5,a4
   10398:	02e78263          	beq	a5,a4,103bc <__libc_init_array+0x4c>
   1039c:	40395913          	sra	s2,s2,0x3
   103a0:	76c40413          	add	s0,s0,1900
   103a4:	00000493          	li	s1,0
   103a8:	00043783          	ld	a5,0(s0)
   103ac:	00148493          	add	s1,s1,1
   103b0:	00840413          	add	s0,s0,8
   103b4:	000780e7          	jalr	a5
   103b8:	ff24e8e3          	bltu	s1,s2,103a8 <__libc_init_array+0x38>
   103bc:	00011437          	lui	s0,0x11
   103c0:	000117b7          	lui	a5,0x11
   103c4:	78078793          	add	a5,a5,1920 # 11780 <__do_global_dtors_aux_fini_array_entry>
   103c8:	77040713          	add	a4,s0,1904 # 11770 <__init_array_start>
   103cc:	40e78933          	sub	s2,a5,a4
   103d0:	40395913          	sra	s2,s2,0x3
   103d4:	02e78063          	beq	a5,a4,103f4 <__libc_init_array+0x84>
   103d8:	77040413          	add	s0,s0,1904
   103dc:	00000493          	li	s1,0
   103e0:	00043783          	ld	a5,0(s0)
   103e4:	00148493          	add	s1,s1,1
   103e8:	00840413          	add	s0,s0,8
   103ec:	000780e7          	jalr	a5
   103f0:	ff24e8e3          	bltu	s1,s2,103e0 <__libc_init_array+0x70>
   103f4:	01813083          	ld	ra,24(sp)
   103f8:	01013403          	ld	s0,16(sp)
   103fc:	00813483          	ld	s1,8(sp)
   10400:	00013903          	ld	s2,0(sp)
   10404:	02010113          	add	sp,sp,32
   10408:	00008067          	ret

000000000001040c <memset>:
   1040c:	00f00313          	li	t1,15
   10410:	00050713          	mv	a4,a0
   10414:	02c37a63          	bgeu	t1,a2,10448 <memset+0x3c>
   10418:	00f77793          	and	a5,a4,15
   1041c:	0a079063          	bnez	a5,104bc <memset+0xb0>
   10420:	06059e63          	bnez	a1,1049c <memset+0x90>
   10424:	ff067693          	and	a3,a2,-16
   10428:	00f67613          	and	a2,a2,15
   1042c:	00e686b3          	add	a3,a3,a4
   10430:	00b73023          	sd	a1,0(a4)
   10434:	00b73423          	sd	a1,8(a4)
   10438:	01070713          	add	a4,a4,16
   1043c:	fed76ae3          	bltu	a4,a3,10430 <memset+0x24>
   10440:	00061463          	bnez	a2,10448 <memset+0x3c>
   10444:	00008067          	ret
   10448:	40c306b3          	sub	a3,t1,a2
   1044c:	00269693          	sll	a3,a3,0x2
   10450:	00000297          	auipc	t0,0x0
   10454:	005686b3          	add	a3,a3,t0
   10458:	00c68067          	jr	12(a3)
   1045c:	00b70723          	sb	a1,14(a4)
   10460:	00b706a3          	sb	a1,13(a4)
   10464:	00b70623          	sb	a1,12(a4)
   10468:	00b705a3          	sb	a1,11(a4)
   1046c:	00b70523          	sb	a1,10(a4)
   10470:	00b704a3          	sb	a1,9(a4)
   10474:	00b70423          	sb	a1,8(a4)
   10478:	00b703a3          	sb	a1,7(a4)
   1047c:	00b70323          	sb	a1,6(a4)
   10480:	00b702a3          	sb	a1,5(a4)
   10484:	00b70223          	sb	a1,4(a4)
   10488:	00b701a3          	sb	a1,3(a4)
   1048c:	00b70123          	sb	a1,2(a4)
   10490:	00b700a3          	sb	a1,1(a4)
   10494:	00b70023          	sb	a1,0(a4)
   10498:	00008067          	ret
   1049c:	0ff5f593          	zext.b	a1,a1
   104a0:	00859693          	sll	a3,a1,0x8
   104a4:	00d5e5b3          	or	a1,a1,a3
   104a8:	01059693          	sll	a3,a1,0x10
   104ac:	00d5e5b3          	or	a1,a1,a3
   104b0:	02059693          	sll	a3,a1,0x20
   104b4:	00d5e5b3          	or	a1,a1,a3
   104b8:	f6dff06f          	j	10424 <memset+0x18>
   104bc:	00279693          	sll	a3,a5,0x2
   104c0:	00000297          	auipc	t0,0x0
   104c4:	005686b3          	add	a3,a3,t0
   104c8:	00008293          	mv	t0,ra
   104cc:	f98680e7          	jalr	-104(a3)
   104d0:	00028093          	mv	ra,t0
   104d4:	ff078793          	add	a5,a5,-16
   104d8:	40f70733          	sub	a4,a4,a5
   104dc:	00f60633          	add	a2,a2,a5
   104e0:	f6c374e3          	bgeu	t1,a2,10448 <memset+0x3c>
   104e4:	f3dff06f          	j	10420 <memset+0x14>

00000000000104e8 <__call_exitprocs>:
   104e8:	fb010113          	add	sp,sp,-80
   104ec:	03413023          	sd	s4,32(sp)
   104f0:	f481ba03          	ld	s4,-184(gp) # 11ed0 <_global_impure_ptr>
   104f4:	03213823          	sd	s2,48(sp)
   104f8:	04113423          	sd	ra,72(sp)
   104fc:	1f8a3903          	ld	s2,504(s4)
   10500:	04813023          	sd	s0,64(sp)
   10504:	02913c23          	sd	s1,56(sp)
   10508:	03313423          	sd	s3,40(sp)
   1050c:	01513c23          	sd	s5,24(sp)
   10510:	01613823          	sd	s6,16(sp)
   10514:	01713423          	sd	s7,8(sp)
   10518:	01813023          	sd	s8,0(sp)
   1051c:	04090063          	beqz	s2,1055c <__call_exitprocs+0x74>
   10520:	00050b13          	mv	s6,a0
   10524:	00058b93          	mv	s7,a1
   10528:	00100a93          	li	s5,1
   1052c:	fff00993          	li	s3,-1
   10530:	00892483          	lw	s1,8(s2)
   10534:	fff4841b          	addw	s0,s1,-1
   10538:	02044263          	bltz	s0,1055c <__call_exitprocs+0x74>
   1053c:	00349493          	sll	s1,s1,0x3
   10540:	009904b3          	add	s1,s2,s1
   10544:	040b8463          	beqz	s7,1058c <__call_exitprocs+0xa4>
   10548:	2084b783          	ld	a5,520(s1)
   1054c:	05778063          	beq	a5,s7,1058c <__call_exitprocs+0xa4>
   10550:	fff4041b          	addw	s0,s0,-1
   10554:	ff848493          	add	s1,s1,-8
   10558:	ff3416e3          	bne	s0,s3,10544 <__call_exitprocs+0x5c>
   1055c:	04813083          	ld	ra,72(sp)
   10560:	04013403          	ld	s0,64(sp)
   10564:	03813483          	ld	s1,56(sp)
   10568:	03013903          	ld	s2,48(sp)
   1056c:	02813983          	ld	s3,40(sp)
   10570:	02013a03          	ld	s4,32(sp)
   10574:	01813a83          	ld	s5,24(sp)
   10578:	01013b03          	ld	s6,16(sp)
   1057c:	00813b83          	ld	s7,8(sp)
   10580:	00013c03          	ld	s8,0(sp)
   10584:	05010113          	add	sp,sp,80
   10588:	00008067          	ret
   1058c:	00892783          	lw	a5,8(s2)
   10590:	0084b703          	ld	a4,8(s1)
   10594:	fff7879b          	addw	a5,a5,-1
   10598:	06878263          	beq	a5,s0,105fc <__call_exitprocs+0x114>
   1059c:	0004b423          	sd	zero,8(s1)
   105a0:	fa0708e3          	beqz	a4,10550 <__call_exitprocs+0x68>
   105a4:	31092783          	lw	a5,784(s2)
   105a8:	008a96bb          	sllw	a3,s5,s0
   105ac:	00892c03          	lw	s8,8(s2)
   105b0:	00d7f7b3          	and	a5,a5,a3
   105b4:	0007879b          	sext.w	a5,a5
   105b8:	02079263          	bnez	a5,105dc <__call_exitprocs+0xf4>
   105bc:	000700e7          	jalr	a4
   105c0:	00892703          	lw	a4,8(s2)
   105c4:	1f8a3783          	ld	a5,504(s4)
   105c8:	01871463          	bne	a4,s8,105d0 <__call_exitprocs+0xe8>
   105cc:	f92782e3          	beq	a5,s2,10550 <__call_exitprocs+0x68>
   105d0:	f80786e3          	beqz	a5,1055c <__call_exitprocs+0x74>
   105d4:	00078913          	mv	s2,a5
   105d8:	f59ff06f          	j	10530 <__call_exitprocs+0x48>
   105dc:	31492783          	lw	a5,788(s2)
   105e0:	1084b583          	ld	a1,264(s1)
   105e4:	00d7f7b3          	and	a5,a5,a3
   105e8:	0007879b          	sext.w	a5,a5
   105ec:	00079c63          	bnez	a5,10604 <__call_exitprocs+0x11c>
   105f0:	000b0513          	mv	a0,s6
   105f4:	000700e7          	jalr	a4
   105f8:	fc9ff06f          	j	105c0 <__call_exitprocs+0xd8>
   105fc:	00892423          	sw	s0,8(s2)
   10600:	fa1ff06f          	j	105a0 <__call_exitprocs+0xb8>
   10604:	00058513          	mv	a0,a1
   10608:	000700e7          	jalr	a4
   1060c:	fb5ff06f          	j	105c0 <__call_exitprocs+0xd8>

0000000000010610 <__libc_fini_array>:
   10610:	fe010113          	add	sp,sp,-32
   10614:	00813823          	sd	s0,16(sp)
   10618:	000117b7          	lui	a5,0x11
   1061c:	00011437          	lui	s0,0x11
   10620:	78078793          	add	a5,a5,1920 # 11780 <__do_global_dtors_aux_fini_array_entry>
   10624:	78840413          	add	s0,s0,1928 # 11788 <impure_data>
   10628:	40f40433          	sub	s0,s0,a5
   1062c:	00913423          	sd	s1,8(sp)
   10630:	00113c23          	sd	ra,24(sp)
   10634:	40345493          	sra	s1,s0,0x3
   10638:	02048063          	beqz	s1,10658 <__libc_fini_array+0x48>
   1063c:	ff840413          	add	s0,s0,-8
   10640:	00f40433          	add	s0,s0,a5
   10644:	00043783          	ld	a5,0(s0)
   10648:	fff48493          	add	s1,s1,-1
   1064c:	ff840413          	add	s0,s0,-8
   10650:	000780e7          	jalr	a5
   10654:	fe0498e3          	bnez	s1,10644 <__libc_fini_array+0x34>
   10658:	01813083          	ld	ra,24(sp)
   1065c:	01013403          	ld	s0,16(sp)
   10660:	00813483          	ld	s1,8(sp)
   10664:	02010113          	add	sp,sp,32
   10668:	00008067          	ret

000000000001066c <atexit>:
   1066c:	00050593          	mv	a1,a0
   10670:	00000693          	li	a3,0
   10674:	00000613          	li	a2,0
   10678:	00000513          	li	a0,0
   1067c:	0040006f          	j	10680 <__register_exitproc>

0000000000010680 <__register_exitproc>:
   10680:	f481b703          	ld	a4,-184(gp) # 11ed0 <_global_impure_ptr>
   10684:	1f873783          	ld	a5,504(a4)
   10688:	06078063          	beqz	a5,106e8 <__register_exitproc+0x68>
   1068c:	0087a703          	lw	a4,8(a5)
   10690:	01f00813          	li	a6,31
   10694:	08e84663          	blt	a6,a4,10720 <__register_exitproc+0xa0>
   10698:	02050863          	beqz	a0,106c8 <__register_exitproc+0x48>
   1069c:	00371813          	sll	a6,a4,0x3
   106a0:	01078833          	add	a6,a5,a6
   106a4:	10c83823          	sd	a2,272(a6)
   106a8:	3107a883          	lw	a7,784(a5)
   106ac:	00100613          	li	a2,1
   106b0:	00e6163b          	sllw	a2,a2,a4
   106b4:	00c8e8b3          	or	a7,a7,a2
   106b8:	3117a823          	sw	a7,784(a5)
   106bc:	20d83823          	sd	a3,528(a6)
   106c0:	00200693          	li	a3,2
   106c4:	02d50863          	beq	a0,a3,106f4 <__register_exitproc+0x74>
   106c8:	00270693          	add	a3,a4,2
   106cc:	00369693          	sll	a3,a3,0x3
   106d0:	0017071b          	addw	a4,a4,1
   106d4:	00e7a423          	sw	a4,8(a5)
   106d8:	00d787b3          	add	a5,a5,a3
   106dc:	00b7b023          	sd	a1,0(a5)
   106e0:	00000513          	li	a0,0
   106e4:	00008067          	ret
   106e8:	20070793          	add	a5,a4,512
   106ec:	1ef73c23          	sd	a5,504(a4)
   106f0:	f9dff06f          	j	1068c <__register_exitproc+0xc>
   106f4:	3147a683          	lw	a3,788(a5)
   106f8:	00000513          	li	a0,0
   106fc:	00c6e6b3          	or	a3,a3,a2
   10700:	30d7aa23          	sw	a3,788(a5)
   10704:	00270693          	add	a3,a4,2
   10708:	00369693          	sll	a3,a3,0x3
   1070c:	0017071b          	addw	a4,a4,1
   10710:	00e7a423          	sw	a4,8(a5)
   10714:	00d787b3          	add	a5,a5,a3
   10718:	00b7b023          	sd	a1,0(a5)
   1071c:	00008067          	ret
   10720:	fff00513          	li	a0,-1
   10724:	00008067          	ret

0000000000010728 <_exit>:
   10728:	05d00893          	li	a7,93
   1072c:	00000073          	ecall
   10730:	00054463          	bltz	a0,10738 <_exit+0x10>
   10734:	0000006f          	j	10734 <_exit+0xc>
   10738:	ff010113          	add	sp,sp,-16
   1073c:	00813023          	sd	s0,0(sp)
   10740:	00050413          	mv	s0,a0
   10744:	00113423          	sd	ra,8(sp)
   10748:	4080043b          	negw	s0,s0
   1074c:	00c000ef          	jal	10758 <__errno>
   10750:	00852023          	sw	s0,0(a0)
   10754:	0000006f          	j	10754 <_exit+0x2c>

0000000000010758 <__errno>:
   10758:	f581b503          	ld	a0,-168(gp) # 11ee0 <_impure_ptr>
   1075c:	00008067          	ret
