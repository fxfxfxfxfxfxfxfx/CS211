
riscv-elf/my_test.riscv:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	294000ef          	jal	10390 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11d78 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	4bc000ef          	jal	105d0 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	4b850513          	add	a0,a0,1208 # 104b8 <__libc_fini_array>
   10128:	3ec0006f          	j	10514 <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00002197          	auipc	gp,0x2
   10134:	d0018193          	add	gp,gp,-768 # 11e30 <__global_pointer$>
   10138:	f6018513          	add	a0,gp,-160 # 11d90 <completed.1>
   1013c:	f9818613          	add	a2,gp,-104 # 11dc8 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	16c000ef          	jal	102b4 <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	3c850513          	add	a0,a0,968 # 10514 <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	36050513          	add	a0,a0,864 # 104b8 <__libc_fini_array>
   10160:	3b4000ef          	jal	10514 <atexit>
   10164:	0b4000ef          	jal	10218 <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	add	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	06c000ef          	jal	101e0 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	add	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11d90 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	61050513          	add	a0,a0,1552 # 11610 <__EH_FRAME_BEGIN__>
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11d90 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	add	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	f6818593          	add	a1,gp,-152 # 11d98 <object.0>
   101d0:	61050513          	add	a0,a0,1552 # 11610 <__EH_FRAME_BEGIN__>
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <main>:
   101e0:	fe010113          	add	sp,sp,-32
   101e4:	00813c23          	sd	s0,24(sp)
   101e8:	02010413          	add	s0,sp,32
   101ec:	000107b7          	lui	a5,0x10
   101f0:	6087a787          	flw	fa5,1544(a5) # 10608 <__errno+0x8>
   101f4:	fef42627          	fsw	fa5,-20(s0)
   101f8:	000107b7          	lui	a5,0x10
   101fc:	60c7a787          	flw	fa5,1548(a5) # 1060c <__errno+0xc>
   10200:	fef42427          	fsw	fa5,-24(s0)
   10204:	00000793          	li	a5,0
   10208:	00078513          	mv	a0,a5
   1020c:	01813403          	ld	s0,24(sp)
   10210:	02010113          	add	sp,sp,32
   10214:	00008067          	ret

0000000000010218 <__libc_init_array>:
   10218:	fe010113          	add	sp,sp,-32
   1021c:	00813823          	sd	s0,16(sp)
   10220:	000117b7          	lui	a5,0x11
   10224:	00011437          	lui	s0,0x11
   10228:	01213023          	sd	s2,0(sp)
   1022c:	61478793          	add	a5,a5,1556 # 11614 <__preinit_array_end>
   10230:	61440713          	add	a4,s0,1556 # 11614 <__preinit_array_end>
   10234:	00113c23          	sd	ra,24(sp)
   10238:	00913423          	sd	s1,8(sp)
   1023c:	40e78933          	sub	s2,a5,a4
   10240:	02e78263          	beq	a5,a4,10264 <__libc_init_array+0x4c>
   10244:	40395913          	sra	s2,s2,0x3
   10248:	61440413          	add	s0,s0,1556
   1024c:	00000493          	li	s1,0
   10250:	00043783          	ld	a5,0(s0)
   10254:	00148493          	add	s1,s1,1
   10258:	00840413          	add	s0,s0,8
   1025c:	000780e7          	jalr	a5
   10260:	ff24e8e3          	bltu	s1,s2,10250 <__libc_init_array+0x38>
   10264:	00011437          	lui	s0,0x11
   10268:	000117b7          	lui	a5,0x11
   1026c:	62878793          	add	a5,a5,1576 # 11628 <__do_global_dtors_aux_fini_array_entry>
   10270:	61840713          	add	a4,s0,1560 # 11618 <__init_array_start>
   10274:	40e78933          	sub	s2,a5,a4
   10278:	40395913          	sra	s2,s2,0x3
   1027c:	02e78063          	beq	a5,a4,1029c <__libc_init_array+0x84>
   10280:	61840413          	add	s0,s0,1560
   10284:	00000493          	li	s1,0
   10288:	00043783          	ld	a5,0(s0)
   1028c:	00148493          	add	s1,s1,1
   10290:	00840413          	add	s0,s0,8
   10294:	000780e7          	jalr	a5
   10298:	ff24e8e3          	bltu	s1,s2,10288 <__libc_init_array+0x70>
   1029c:	01813083          	ld	ra,24(sp)
   102a0:	01013403          	ld	s0,16(sp)
   102a4:	00813483          	ld	s1,8(sp)
   102a8:	00013903          	ld	s2,0(sp)
   102ac:	02010113          	add	sp,sp,32
   102b0:	00008067          	ret

00000000000102b4 <memset>:
   102b4:	00f00313          	li	t1,15
   102b8:	00050713          	mv	a4,a0
   102bc:	02c37a63          	bgeu	t1,a2,102f0 <memset+0x3c>
   102c0:	00f77793          	and	a5,a4,15
   102c4:	0a079063          	bnez	a5,10364 <memset+0xb0>
   102c8:	06059e63          	bnez	a1,10344 <memset+0x90>
   102cc:	ff067693          	and	a3,a2,-16
   102d0:	00f67613          	and	a2,a2,15
   102d4:	00e686b3          	add	a3,a3,a4
   102d8:	00b73023          	sd	a1,0(a4)
   102dc:	00b73423          	sd	a1,8(a4)
   102e0:	01070713          	add	a4,a4,16
   102e4:	fed76ae3          	bltu	a4,a3,102d8 <memset+0x24>
   102e8:	00061463          	bnez	a2,102f0 <memset+0x3c>
   102ec:	00008067          	ret
   102f0:	40c306b3          	sub	a3,t1,a2
   102f4:	00269693          	sll	a3,a3,0x2
   102f8:	00000297          	auipc	t0,0x0
   102fc:	005686b3          	add	a3,a3,t0
   10300:	00c68067          	jr	12(a3)
   10304:	00b70723          	sb	a1,14(a4)
   10308:	00b706a3          	sb	a1,13(a4)
   1030c:	00b70623          	sb	a1,12(a4)
   10310:	00b705a3          	sb	a1,11(a4)
   10314:	00b70523          	sb	a1,10(a4)
   10318:	00b704a3          	sb	a1,9(a4)
   1031c:	00b70423          	sb	a1,8(a4)
   10320:	00b703a3          	sb	a1,7(a4)
   10324:	00b70323          	sb	a1,6(a4)
   10328:	00b702a3          	sb	a1,5(a4)
   1032c:	00b70223          	sb	a1,4(a4)
   10330:	00b701a3          	sb	a1,3(a4)
   10334:	00b70123          	sb	a1,2(a4)
   10338:	00b700a3          	sb	a1,1(a4)
   1033c:	00b70023          	sb	a1,0(a4)
   10340:	00008067          	ret
   10344:	0ff5f593          	zext.b	a1,a1
   10348:	00859693          	sll	a3,a1,0x8
   1034c:	00d5e5b3          	or	a1,a1,a3
   10350:	01059693          	sll	a3,a1,0x10
   10354:	00d5e5b3          	or	a1,a1,a3
   10358:	02059693          	sll	a3,a1,0x20
   1035c:	00d5e5b3          	or	a1,a1,a3
   10360:	f6dff06f          	j	102cc <memset+0x18>
   10364:	00279693          	sll	a3,a5,0x2
   10368:	00000297          	auipc	t0,0x0
   1036c:	005686b3          	add	a3,a3,t0
   10370:	00008293          	mv	t0,ra
   10374:	f98680e7          	jalr	-104(a3)
   10378:	00028093          	mv	ra,t0
   1037c:	ff078793          	add	a5,a5,-16
   10380:	40f70733          	sub	a4,a4,a5
   10384:	00f60633          	add	a2,a2,a5
   10388:	f6c374e3          	bgeu	t1,a2,102f0 <memset+0x3c>
   1038c:	f3dff06f          	j	102c8 <memset+0x14>

0000000000010390 <__call_exitprocs>:
   10390:	fb010113          	add	sp,sp,-80
   10394:	03413023          	sd	s4,32(sp)
   10398:	f481ba03          	ld	s4,-184(gp) # 11d78 <_global_impure_ptr>
   1039c:	03213823          	sd	s2,48(sp)
   103a0:	04113423          	sd	ra,72(sp)
   103a4:	1f8a3903          	ld	s2,504(s4)
   103a8:	04813023          	sd	s0,64(sp)
   103ac:	02913c23          	sd	s1,56(sp)
   103b0:	03313423          	sd	s3,40(sp)
   103b4:	01513c23          	sd	s5,24(sp)
   103b8:	01613823          	sd	s6,16(sp)
   103bc:	01713423          	sd	s7,8(sp)
   103c0:	01813023          	sd	s8,0(sp)
   103c4:	04090063          	beqz	s2,10404 <__call_exitprocs+0x74>
   103c8:	00050b13          	mv	s6,a0
   103cc:	00058b93          	mv	s7,a1
   103d0:	00100a93          	li	s5,1
   103d4:	fff00993          	li	s3,-1
   103d8:	00892483          	lw	s1,8(s2)
   103dc:	fff4841b          	addw	s0,s1,-1
   103e0:	02044263          	bltz	s0,10404 <__call_exitprocs+0x74>
   103e4:	00349493          	sll	s1,s1,0x3
   103e8:	009904b3          	add	s1,s2,s1
   103ec:	040b8463          	beqz	s7,10434 <__call_exitprocs+0xa4>
   103f0:	2084b783          	ld	a5,520(s1)
   103f4:	05778063          	beq	a5,s7,10434 <__call_exitprocs+0xa4>
   103f8:	fff4041b          	addw	s0,s0,-1
   103fc:	ff848493          	add	s1,s1,-8
   10400:	ff3416e3          	bne	s0,s3,103ec <__call_exitprocs+0x5c>
   10404:	04813083          	ld	ra,72(sp)
   10408:	04013403          	ld	s0,64(sp)
   1040c:	03813483          	ld	s1,56(sp)
   10410:	03013903          	ld	s2,48(sp)
   10414:	02813983          	ld	s3,40(sp)
   10418:	02013a03          	ld	s4,32(sp)
   1041c:	01813a83          	ld	s5,24(sp)
   10420:	01013b03          	ld	s6,16(sp)
   10424:	00813b83          	ld	s7,8(sp)
   10428:	00013c03          	ld	s8,0(sp)
   1042c:	05010113          	add	sp,sp,80
   10430:	00008067          	ret
   10434:	00892783          	lw	a5,8(s2)
   10438:	0084b703          	ld	a4,8(s1)
   1043c:	fff7879b          	addw	a5,a5,-1
   10440:	06878263          	beq	a5,s0,104a4 <__call_exitprocs+0x114>
   10444:	0004b423          	sd	zero,8(s1)
   10448:	fa0708e3          	beqz	a4,103f8 <__call_exitprocs+0x68>
   1044c:	31092783          	lw	a5,784(s2)
   10450:	008a96bb          	sllw	a3,s5,s0
   10454:	00892c03          	lw	s8,8(s2)
   10458:	00d7f7b3          	and	a5,a5,a3
   1045c:	0007879b          	sext.w	a5,a5
   10460:	02079263          	bnez	a5,10484 <__call_exitprocs+0xf4>
   10464:	000700e7          	jalr	a4
   10468:	00892703          	lw	a4,8(s2)
   1046c:	1f8a3783          	ld	a5,504(s4)
   10470:	01871463          	bne	a4,s8,10478 <__call_exitprocs+0xe8>
   10474:	f92782e3          	beq	a5,s2,103f8 <__call_exitprocs+0x68>
   10478:	f80786e3          	beqz	a5,10404 <__call_exitprocs+0x74>
   1047c:	00078913          	mv	s2,a5
   10480:	f59ff06f          	j	103d8 <__call_exitprocs+0x48>
   10484:	31492783          	lw	a5,788(s2)
   10488:	1084b583          	ld	a1,264(s1)
   1048c:	00d7f7b3          	and	a5,a5,a3
   10490:	0007879b          	sext.w	a5,a5
   10494:	00079c63          	bnez	a5,104ac <__call_exitprocs+0x11c>
   10498:	000b0513          	mv	a0,s6
   1049c:	000700e7          	jalr	a4
   104a0:	fc9ff06f          	j	10468 <__call_exitprocs+0xd8>
   104a4:	00892423          	sw	s0,8(s2)
   104a8:	fa1ff06f          	j	10448 <__call_exitprocs+0xb8>
   104ac:	00058513          	mv	a0,a1
   104b0:	000700e7          	jalr	a4
   104b4:	fb5ff06f          	j	10468 <__call_exitprocs+0xd8>

00000000000104b8 <__libc_fini_array>:
   104b8:	fe010113          	add	sp,sp,-32
   104bc:	00813823          	sd	s0,16(sp)
   104c0:	000117b7          	lui	a5,0x11
   104c4:	00011437          	lui	s0,0x11
   104c8:	62878793          	add	a5,a5,1576 # 11628 <__do_global_dtors_aux_fini_array_entry>
   104cc:	63040413          	add	s0,s0,1584 # 11630 <impure_data>
   104d0:	40f40433          	sub	s0,s0,a5
   104d4:	00913423          	sd	s1,8(sp)
   104d8:	00113c23          	sd	ra,24(sp)
   104dc:	40345493          	sra	s1,s0,0x3
   104e0:	02048063          	beqz	s1,10500 <__libc_fini_array+0x48>
   104e4:	ff840413          	add	s0,s0,-8
   104e8:	00f40433          	add	s0,s0,a5
   104ec:	00043783          	ld	a5,0(s0)
   104f0:	fff48493          	add	s1,s1,-1
   104f4:	ff840413          	add	s0,s0,-8
   104f8:	000780e7          	jalr	a5
   104fc:	fe0498e3          	bnez	s1,104ec <__libc_fini_array+0x34>
   10500:	01813083          	ld	ra,24(sp)
   10504:	01013403          	ld	s0,16(sp)
   10508:	00813483          	ld	s1,8(sp)
   1050c:	02010113          	add	sp,sp,32
   10510:	00008067          	ret

0000000000010514 <atexit>:
   10514:	00050593          	mv	a1,a0
   10518:	00000693          	li	a3,0
   1051c:	00000613          	li	a2,0
   10520:	00000513          	li	a0,0
   10524:	0040006f          	j	10528 <__register_exitproc>

0000000000010528 <__register_exitproc>:
   10528:	f481b703          	ld	a4,-184(gp) # 11d78 <_global_impure_ptr>
   1052c:	1f873783          	ld	a5,504(a4)
   10530:	06078063          	beqz	a5,10590 <__register_exitproc+0x68>
   10534:	0087a703          	lw	a4,8(a5)
   10538:	01f00813          	li	a6,31
   1053c:	08e84663          	blt	a6,a4,105c8 <__register_exitproc+0xa0>
   10540:	02050863          	beqz	a0,10570 <__register_exitproc+0x48>
   10544:	00371813          	sll	a6,a4,0x3
   10548:	01078833          	add	a6,a5,a6
   1054c:	10c83823          	sd	a2,272(a6)
   10550:	3107a883          	lw	a7,784(a5)
   10554:	00100613          	li	a2,1
   10558:	00e6163b          	sllw	a2,a2,a4
   1055c:	00c8e8b3          	or	a7,a7,a2
   10560:	3117a823          	sw	a7,784(a5)
   10564:	20d83823          	sd	a3,528(a6)
   10568:	00200693          	li	a3,2
   1056c:	02d50863          	beq	a0,a3,1059c <__register_exitproc+0x74>
   10570:	00270693          	add	a3,a4,2
   10574:	00369693          	sll	a3,a3,0x3
   10578:	0017071b          	addw	a4,a4,1
   1057c:	00e7a423          	sw	a4,8(a5)
   10580:	00d787b3          	add	a5,a5,a3
   10584:	00b7b023          	sd	a1,0(a5)
   10588:	00000513          	li	a0,0
   1058c:	00008067          	ret
   10590:	20070793          	add	a5,a4,512
   10594:	1ef73c23          	sd	a5,504(a4)
   10598:	f9dff06f          	j	10534 <__register_exitproc+0xc>
   1059c:	3147a683          	lw	a3,788(a5)
   105a0:	00000513          	li	a0,0
   105a4:	00c6e6b3          	or	a3,a3,a2
   105a8:	30d7aa23          	sw	a3,788(a5)
   105ac:	00270693          	add	a3,a4,2
   105b0:	00369693          	sll	a3,a3,0x3
   105b4:	0017071b          	addw	a4,a4,1
   105b8:	00e7a423          	sw	a4,8(a5)
   105bc:	00d787b3          	add	a5,a5,a3
   105c0:	00b7b023          	sd	a1,0(a5)
   105c4:	00008067          	ret
   105c8:	fff00513          	li	a0,-1
   105cc:	00008067          	ret

00000000000105d0 <_exit>:
   105d0:	05d00893          	li	a7,93
   105d4:	00000073          	ecall
   105d8:	00054463          	bltz	a0,105e0 <_exit+0x10>
   105dc:	0000006f          	j	105dc <_exit+0xc>
   105e0:	ff010113          	add	sp,sp,-16
   105e4:	00813023          	sd	s0,0(sp)
   105e8:	00050413          	mv	s0,a0
   105ec:	00113423          	sd	ra,8(sp)
   105f0:	4080043b          	negw	s0,s0
   105f4:	00c000ef          	jal	10600 <__errno>
   105f8:	00852023          	sw	s0,0(a0)
   105fc:	0000006f          	j	105fc <_exit+0x2c>

0000000000010600 <__errno>:
   10600:	f581b503          	ld	a0,-168(gp) # 11d88 <_impure_ptr>
   10604:	00008067          	ret
