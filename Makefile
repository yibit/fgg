# Temporary makefile for testing, e.g., -monom
# TODO: ^should be integrated with `go test` instead


#.PHONY: build
#build:
#	go build oopsla20-91/fgg
#
#
#.PHONY: install
#install:
#	go install oopsla20-91/fgg

.PHONY: test
test: test-fg test-fgg test-fg2fgg

.PHONY: test-against-go
test-against-go: test-fg-examples-against-go test-monom-against-go

.PHONY: test-all
test-all: test test-against-go

.PHONY: clean
clean: clean-test-all

#rm -f ../../../../bin/fgg.exe
#make test-clean


.PHONY: test-fg
test-fg: test-fg-unit test-fg-examples


.PHONY: test-fg-unit
test-fg-unit:
	go test oopsla20-91/fgg/fg


define eval_fg
	RES=`go run oopsla20-91/fgg -eval=$(2) $(1)`; \
	EXIT=$$?; if [ $$EXIT -ne 0 ]; then exit $$EXIT; fi; \
	echo $$RES
endef

.PHONY: test-fg-examples
test-fg-examples:
	$(call eval_fg,fg/examples/hello/hello.go,10)
	$(call eval_fg,fg/examples/hello/fmtprintf.go,10)

	$(call eval_fg,fg/examples/prev/booleans/booleans.go,-1)
	$(call eval_fg,fg/examples/prev/compose/compose.go,-1)
	$(call eval_fg,fg/examples/prev/equal/equal.go,-1)
	$(call eval_fg,fg/examples/prev/incr/incr.go,-1)
	$(call eval_fg,fg/examples/prev/map/map.go,-1)
	$(call eval_fg,fg/examples/prev/not/not.go,-1)

	$(call eval_fg,fg/examples/oopsla20/fig1/functions.go,-1)
	$(call eval_fg,fg/examples/oopsla20/fig2/lists.go,-1)
	$(call eval_fg,fg/examples/oopsla20/fig7/monom.go,-1)


# TODO: currently examples testing limited to "good" examples


# N.B. semicolons and line esacapes, and double-dollar
define test_fg_against_go
	EXP=`go run oopsla20-91/fgg -eval=-1 -printf $(1)`; \
	echo "fg="$$EXP; \
	ACT=`go run $(1)`; \
	echo "go="$$ACT; \
	if [ "$$EXP" != "$$ACT" ]; then \
		echo "Not equal."; \
		exit 1; \
	fi
endef


# cf. [cmd] > output.txt
#     diff output.txt correct.txt
.PHONY: test-fg-examples-against-go
test-fg-examples-against-go:
		$(call test_fg_against_go,fg/examples/prev/booleans/booleans.go)
		$(call test_fg_against_go,fg/examples/prev/compose/compose.go)
		$(call test_fg_against_go,fg/examples/prev/equal/equal.go)
		$(call test_fg_against_go,fg/examples/prev/incr/incr.go)
		$(call test_fg_against_go,fg/examples/prev/map/map.go)
		$(call test_fg_against_go,fg/examples/prev/not/not.go)

		$(call test_fg_against_go,fg/examples/oopsla20/fig1/functions.go)
		$(call test_fg_against_go,fg/examples/oopsla20/fig2/lists.go)
		$(call test_fg_against_go,fg/examples/oopsla20/fig7/monom.go)


.PHONY: test-fgg
#test-fgg: test-fgg-unit test-fgg-examples
test-fgg: test-fgg-unit test-nomono-bad simulate-monom simulate-oblit
# add monom, oblit?


.PHONY: test-fgg-unit
test-fgg-unit:
	go test oopsla20-91/fgg/fgg


define eval_fgg
	RES=`go run oopsla20-91/fgg -fgg -eval=$(2) $(1)`; \
	EXIT=$$?; if [ $$EXIT -ne 0 ]; then exit $$EXIT; fi; \
	echo $$RES
endef

#.PHONY: foo
#foo:
#	declare -a arr=(\
#		"element1" \
#		"element2" \
#		"element3"); \
#	for i in "$${arr[@]}"; \
#	do \
#   	 echo "$$i"; \
#	done


# Subsumed by, e.g., simulate-monom
.PHONY: test-fgg-examples
test-fgg-examples:
	$(call eval_fgg,fgg/examples/hello/hello.fgg,10)
	$(call eval_fgg,fgg/examples/hello/fmtprintf.fgg,10)

	$(call eval_fgg,fgg/examples/prev/booleans/booleans.fgg,-1)
	$(call eval_fgg,fgg/examples/prev/compose/compose.fgg,-1)
	$(call eval_fgg,fgg/examples/prev/graph/graph.fgg,-1)
	$(call eval_fgg,fgg/examples/prev/irregular/irregular.fgg,-1)
	$(call eval_fgg,fgg/examples/prev/map/map.fgg,-1)
	$(call eval_fgg,fgg/examples/prev/monomorph/monomorph.fgg,-1)

	$(call eval_fgg,fgg/examples/monom/box/box.fgg,10)
	$(call eval_fgg,fgg/examples/monom/box/box2.fgg,10)

	$(call eval_fgg,fgg/examples/monom/abcdef/ifacebox.fgg,-1)

	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/iface-embedding-simple.go,-1)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/iface-embedding.go,-1)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/rcver-iface.go,-1)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/one-pass-prob.go,-1)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/contamination.go,-1)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/struct-poly-rec.go,-1)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/Parameterised-Map.go,-1)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/alternate.go,10)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/i-closure.go,-1)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/i-closure-bad.go,-1)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/meth-clash.go,7)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/param-meth-cast.go,2)
	$(call eval_fgg,fgg/examples/monom/abcdef/mono-ok/poly-rec-iface.go,10)

	$(call eval_fgg,fgg/examples/oopsla20/fig3/functions.fgg,-1)
	$(call eval_fgg,fgg/examples/oopsla20/fig4/lists.fgg,-1)
	$(call eval_fgg,fgg/examples/oopsla20/fig5/graph.fgg,-1)
	$(call eval_fgg,fgg/examples/oopsla20/fig6/expression.fgg,-1)


define nomono_bad
	RES=`go run oopsla20-91/fgg -fgg -monomc=-- $(1) 2> /dev/null`; \
	EXIT=$$?; if [ $$EXIT -ne 1 ]; then \
		echo "Expected nomono violation, but none occurred."; \
		exit 1; \
	fi; 
endef

.PHONY: test-nomono-bad
test-nomono-bad:
	$(call nomono_bad,fgg/examples/monom/box/box.fgg)

	$(call nomono_bad,fgg/examples/monom/abcdef/mono-ko/incompleteness-subtyping.go)
	$(call nomono_bad,fgg/examples/monom/abcdef/mono-ko/monom-imp.go)
	$(call nomono_bad,fgg/examples/monom/abcdef/mono-ko/mutual-poly-rec.go)
	$(call nomono_bad,fgg/examples/monom/abcdef/mono-ko/mutual-rec-iface.go)
	$(call nomono_bad,fgg/examples/monom/abcdef/mono-ko/nested-fix.go)
	$(call nomono_bad,fgg/examples/monom/abcdef/mono-ko/two-type-param.go)


define sim_monom
	`go run oopsla20-91/fgg -test-monom -eval=$(2) $(1)`; \
	EXIT=$$?; if [ $$EXIT -ne 0 ]; then exit $$EXIT; fi
endef

.PHONY: simulate-monom
simulate-monom:
	$(call sim_monom,fgg/examples/hello/hello.fgg,10)
	$(call sim_monom,fgg/examples/hello/fmtprintf.fgg,10)

	$(call sim_monom,fgg/examples/prev/booleans/booleans.fgg,-1)
	$(call sim_monom,fgg/examples/prev/compose/compose.fgg,-1)
	$(call sim_monom,fgg/examples/prev/graph/graph.fgg,-1)
	$(call sim_monom,fgg/examples/prev/irregular/irregular.fgg,-1)
	$(call sim_monom,fgg/examples/prev/map/map.fgg,-1)
	$(call sim_monom,fgg/examples/prev/monomorph/monomorph.fgg,-1)

	$(call sim_monom,fgg/examples/monom/box/box.fgg,10)
	$(call sim_monom,fgg/examples/monom/box/box2.fgg,10)

	$(call sim_monom,fgg/examples/monom/abcdef/ifacebox.fgg,-1)

	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/iface-embedding-simple.go,-1)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/iface-embedding.go,-1)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/rcver-iface.go,-1)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/one-pass-prob.go,-1)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/contamination.go,-1)

	# TODO: add to oblit
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/struct-poly-rec.go,-1)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/Parameterised-Map.go,-1)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/alternate.go,10)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/i-closure.go,-1)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/i-closure-bad.go,-1)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/meth-clash.go,7)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/param-meth-cast.go,2)
	$(call sim_monom,fgg/examples/monom/abcdef/mono-ok/poly-rec-iface.go,10)

	$(call sim_monom,fgg/examples/oopsla20/fig3/functions.fgg,-1)
	$(call sim_monom,fgg/examples/oopsla20/fig4/lists.fgg,-1)
	$(call sim_monom,fgg/examples/oopsla20/fig5/graph.fgg,-1)
	#$(call sim_monom,fgg/examples/oopsla20/fig6/expression.fgg,-1)


define eval_monom_fgg
	mkdir -p $(3); \
	RES=`go run oopsla20-91/fgg -fgg -eval=$(2) -monomc=$(3)/$(4) $(1)`; \
	EXIT=$$?; if [ $$EXIT -ne 0 ]; then exit $$EXIT; fi; \
	echo "fgg="$$RES; \
	EXP=`go run oopsla20-91/fgg -eval=$(2) $(3)/$(4)`; \
	EXIT=$$?; if [ $$EXIT -ne 0 ]; then exit $$EXIT; fi; \
	echo "fg= "$$EXP
endef

define eval_monom_fgg_against_go
	mkdir -p $(2); \
	RES=`go run oopsla20-91/fgg -fgg -eval=-1 -monomc=$(2)/$(3) $(1)`; \
	EXIT=$$?; if [ $$EXIT -ne 0 ]; then exit $$EXIT; fi; \
	echo "fgg="$$RES; \
	EXP=`go run oopsla20-91/fgg -eval=-1 -printf $(2)/$(3)`; \
	echo "fg= "$$EXP; \
	ACT=`go run $(2)/$(3)`; \
	echo "go= "$$ACT; \
	if [ "$$EXP" != "$$ACT" ]; then \
		echo "Not equal."; \
		exit 1; \
	fi
endef

# Non-terminating examples tested by simulate-monom
.PHONY: test-monom-against-go
test-monom-against-go:
	$(call eval_monom_fgg_against_go,fgg/examples/prev/booleans/booleans.fgg,tmp/test/fg/booleans,booleans.go)
	$(call eval_monom_fgg_against_go,fgg/examples/prev/compose/compose.fgg,tmp/test/fg/compose,compose.go)
	$(call eval_monom_fgg_against_go,fgg/examples/prev/graph/graph.fgg,tmp/test/fg/graph,graph.go)
	$(call eval_monom_fgg_against_go,fgg/examples/prev/irregular/irregular.fgg,tmp/test/fg/irregular,irregular.go)
	$(call eval_monom_fgg_against_go,fgg/examples/prev/map/map.fgg,tmp/test/fg/map,map.go)
	$(call eval_monom_fgg_against_go,fgg/examples/prev/monomorph/monomorph.fgg,tmp/test/fg/monomorph,monomorph.go)

	#$(call eval_monom_fgg,fgg/examples/monom/box/box2.fgg,10,tmp/test/fg/monom/box,box2.go)

	$(call eval_monom_fgg_against_go,fgg/examples/monom/abcdef/ifacebox.fgg,tmp/test/fg/monom/abcdef/ifacebox,ifacebox.go)

	$(call eval_monom_fgg_against_go,fgg/examples/monom/abcdef/mono-ok/iface-embedding-simple.go,tmp/test/fg/monom/abcdef/mono-ok/iface-embedding-simple,iface-embedding-simple.go)
	$(call eval_monom_fgg_against_go,fgg/examples/monom/abcdef/mono-ok/iface-embedding.go,tmp/test/fg/monom/abcdef/mono-ok/iface-embedding,iface-embedding.go)
	$(call eval_monom_fgg_against_go,fgg/examples/monom/abcdef/mono-ok/rcver-iface.go,tmp/test/fg/monom/abcdef/mono-ok/rcver-iface,rcver-iface.go)
	$(call eval_monom_fgg_against_go,fgg/examples/monom/abcdef/mono-ok/one-pass-prob.go,tmp/test/fg/monom/abcdef/mono-ok/one-pass-prob,one-pass-prob.go)
	$(call eval_monom_fgg_against_go,fgg/examples/monom/abcdef/mono-ok/contamination.go,tmp/test/fg/monom/abcdef/mono-ok/contamination,contamination.go)

	# TODO: add to oblit
	$(call eval_monom_fgg_against_go,fgg/examples/monom/abcdef/mono-ok/struct-poly-rec.go,tmp/test/fg/monom/abcdef/mono-ok/struct-poly-rec,struct-poly-rec.go)
	$(call eval_monom_fgg_against_go,fgg/examples/monom/abcdef/mono-ok/Parameterised-Map.go,tmp/test/fg/monom/abcdef/mono-ok/Parameterised-Map,Parameterised-Map.go)
	#$(call eval_monom_fgg,fgg/examples/monom/abcdef/mono-ok/alternate.go,10,tmp/test/fg/monom/abcdef/mono-ok/alternate,alternate.go)
	$(call eval_monom_fgg_against_go,fgg/examples/monom/abcdef/mono-ok/i-closure.go,tmp/test/fg/monom/abcdef/mono-ok/i-closure,i-closure.go)
	$(call eval_monom_fgg_against_go,fgg/examples/monom/abcdef/mono-ok/i-closure-bad.go,tmp/test/fg/monom/abcdef/mono-ok/i-closure-bad,i-closure-bad.go)
	#$(call eval_monom_fgg,fgg/examples/monom/abcdef/mono-ok/meth-clash.go,7,tmp/test/fg/monom/abcdef/mono-ok/meth-clash,meth-clash.go)
	#$(call eval_monom_fgg,fgg/examples/monom/abcdef/mono-ok/param-meth-cast.go,2,tmp/test/fg/monom/abcdef/mono-ok/param-meth-cast,param-meth-cast.go)
	#$(call eval_monom_fgg,fgg/examples/monom/abcdef/mono-ok/poly-rec-iface.go,10,tmp/test/fg/monom/abcdef/mono-ok/poly-rec-iface,poly-rec-iface.go)

	#mkdir -p tmp/test/fg/monom/abcdef/mono-ko

	$(call eval_monom_fgg_against_go,fgg/examples/oopsla20/fig3/functions.fgg,tmp/test/fg/oopsla20/functions,functions.go)
	$(call eval_monom_fgg_against_go,fgg/examples/oopsla20/fig4/lists.fgg,tmp/test/fg/oopsla20/lists,lists.go)
	$(call eval_monom_fgg_against_go,fgg/examples/oopsla20/fig5/graph.fgg,tmp/test/fg/oopsla20/graph,graph.go)
	#$(call eval_monom_fgg_against_go,fgg/examples/oopsla20/fig6/expression.fgg,tmp/test/fg/oopsla20/expression,expression.go)  #go= "({{{}}}+{{}})" 

define rm_monom
	rm -f $(1)/$(2); \
	rm -fd $(1)
endef

.PHONY: clean-test-monom-against-go
clean-test-monom-against-go:
	$(call rm_monom,tmp/test/fg/booleans,booleans.go)
	$(call rm_monom,tmp/test/fg/compose,compose.go)
	$(call rm_monom,tmp/test/fg/graph,graph.go)
	$(call rm_monom,tmp/test/fg/irregular,irregular.go)
	$(call rm_monom,tmp/test/fg/map,map.go)
	$(call rm_monom,tmp/test/fg/monomorph,monomorph.go)

	#rm -f tmp/test/fg/monom/box/box2.go
	#rm -fd tmp/test/fg/monom/box

	$(call rm_monom,tmp/test/fg/monom/abcdef/ifacebox,ifacebox.go)

	$(call rm_monom,tmp/test/fg/monom/abcdef/mono-ok/iface-embedding-simple,iface-embedding-simple.go)
	$(call rm_monom,tmp/test/fg/monom/abcdef/mono-ok/iface-embedding,iface-embedding.go)
	$(call rm_monom,tmp/test/fg/monom/abcdef/mono-ok/rcver-iface,rcver-iface.go)
	$(call rm_monom,tmp/test/fg/monom/abcdef/mono-ok/one-pass-prob,one-pass-prob.go)
	$(call rm_monom,tmp/test/fg/monom/abcdef/mono-ok/contamination,contamination.go)
	$(call rm_monom,tmp/test/fg/monom/abcdef/mono-ok/struct-poly-rec,struct-poly-rec.go)
	$(call rm_monom,tmp/test/fg/monom/abcdef/mono-ok/Parameterised-Map,Parameterised-Map.go)
	$(call rm_monom,tmp/test/fg/monom/abcdef/mono-ok/i-closure,i-closure.go)
	$(call rm_monom,tmp/test/fg/monom/abcdef/mono-ok/i-closure-bad,i-closure-bad.go)

	rm -fd tmp/test/fg/monom/abcdef/mono-ok
	rm -fd tmp/test/fg/monom/abcdef/mono-ko
	rm -fd tmp/test/fg/monom/abcdef
	rm -fd tmp/test/fg/monom

	$(call rm_monom,tmp/test/fg/oopsla20/functions,functions.go)
	$(call rm_monom,tmp/test/fg/oopsla20/lists,lists.go)
	$(call rm_monom,tmp/test/fg/oopsla20/graph,graph.go)
	$(call rm_monom,tmp/test/fg/oopsla20/expression,expression.go)

	rm -fd tmp/test/fg/oopsla20


.PHONY: simulate-oblit
simulate-oblit:
	go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/prev/booleans/booleans.fgg
	go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/prev/compose/compose.fgg
	go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/prev/graph/graph.fgg
	go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/prev/irregular/irregular.fgg
	go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/prev/map/map.fgg
	go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/prev/monomorph/monomorph.fgg
	# TODO: currently trying to run to termination
	#go run oopsla20-91/fgg -test-oblit -eval=10 fgg/examples/monom/box/box.fgg
	#go run oopsla20-91/fgg -test-oblit -eval=10 fgg/examples/monom/box/box2.fgg

	go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/monom/abcdef/ifacebox.fgg

	# TODO?
	#go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/monom/abcdef/iface-embedding-simple.go
	#go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/monom/abcdef/iface-embedding.go

	go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/monom/abcdef/mono-ok/rcver-iface.go
	go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/monom/abcdef/mono-ok/one-pass-prob.go
	go run oopsla20-91/fgg -test-oblit -eval=-1 fgg/examples/monom/abcdef/mono-ok/contamination.go


# TODO: update
.PHONY: test-oblit
test-oblit:
	mkdir -p tmp/test-oblit/fgr/booleans
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/booleans/booleans.fgr -oblit-eval=-1 fgg/examples/prev/booleans/booleans.fgg
# TODO: standalone FGR execution (.fgr output currently unused)
# 
	mkdir -p tmp/test-oblit/fgr/compose
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/compose/compose.fgr -oblit-eval=-1 fgg/examples/prev/compose/compose.fgg

	mkdir -p tmp/test-oblit/fgr/graph
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/graph/graph.fgr -oblit-eval=-1 fgg/examples/prev/graph/graph.fgg

	mkdir -p tmp/test-oblit/fgr/irregular
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/irregular/irregular.fgr -oblit-eval=-1 fgg/examples/prev/irregular/irregular.fgg

	mkdir -p tmp/test-oblit/fgr/map
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/map/map.fgr -oblit-eval=-1 fgg/examples/prev/map/map.fgg

	mkdir -p tmp/test-oblit/fgr/monomorph
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/monomorph/monomorph.fgr -oblit-eval=-1 fgg/examples/prev/monomorph/monomorph.fgg

	mkdir -p tmp/test-oblit/fgr/box
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/box/box.fgr -oblit-eval=10 fgg/examples/monom/box/box.fgg
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/box/box2.fgr -oblit-eval=10 fgg/examples/monom/box/box2.fgg

	mkdir -p tmp/test-oblit/fgr/abcdef
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/abcdef/ifacebox.fgr -oblit-eval=-1 fgg/examples/monom/abcdef/ifacebox.fgg
	# TODO: i/face embedding?
	#go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/abcdef/iface-embedding-simple.fgr -oblit-eval=-1 fgg/examples/monom/abcdef/iface-embedding-simple.go
	#go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/abcdef/iface-embedding.fgr -oblit-eval=-1 fgg/examples/monom/abcdef/iface-embedding.go

	mkdir -p tmp/test-oblit/fgr/abcdef/mono-ok
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/abcdef/mono-ok/rcver-iface.fgr -oblit-eval=-1 fgg/examples/monom/abcdef/mono-ok/rcver-iface.go
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/abcdef/mono-ok/one-pass-prob.fgr -oblit-eval=-1 fgg/examples/monom/abcdef/mono-ok/one-pass-prob.go
	go run oopsla20-91/fgg -fgg -oblitc=tmp/test-oblit/fgr/abcdef/mono-ok/contamination.fgr -oblit-eval=-1 fgg/examples/monom/abcdef/mono-ok/contamination.go

	mkdir -p tmp/test-oblit/fgr/abcdef/mono-ko


.PHONY: clean-test-oblit
clean-test-oblit:
	rm -f tmp/test-oblit/fgr/booleans/booleans.fgr
	rm -fd tmp/test-oblit/fgr/booleans

	rm -f tmp/test-oblit/fgr/compose/compose.fgr
	rm -fd tmp/test-oblit/fgr/compose

	rm -f tmp/test-oblit/fgr/graph/graph.fgr
	rm -fd tmp/test-oblit/fgr/graph

	rm -f tmp/test-oblit/fgr/irregular/irregular.fgr
	rm -fd tmp/test-oblit/fgr/irregular

	rm -f tmp/test-oblit/fgr/map/map.fgr
	rm -fd tmp/test-oblit/fgr/map

	rm -f tmp/test-oblit/fgr/monomorph/monomorph.fgr
	rm -fd tmp/test-oblit/fgr/monomorph

	rm -f tmp/test-oblit/fgr/box/box.fgr
	rm -f tmp/test-oblit/fgr/box/box2.fgr
	rm -fd tmp/test-oblit/fgr/box

	rm -f tmp/test-oblit/fgr/abcdef/mono-ok/rcver-iface.fgr
	rm -f tmp/test-oblit/fgr/abcdef/mono-ok/one-pass-prob.fgr
	rm -f tmp/test-oblit/fgr/abcdef/mono-ok/contamination.fgr
	rm -fd tmp/test-oblit/fgr/abcdef/mono-ok

	rm -fd tmp/test-oblit/fgr/abcdef/mono-ko

	rm -f tmp/test-oblit/fgr/abcdef/ifacebox.fgr
	rm -fd tmp/test-oblit/fgr/abcdef


.PHONY: test-fg2fgg
test-fg2fgg:
	mkdir -p tmp/test/fgg/booleans
	go run oopsla20-91/fgg/cmd/fg2fgg fg/examples/prev/booleans/booleans.go > tmp/test/fgg/booleans/booleans.fgg
	go run oopsla20-91/fgg -fgg -eval=-1 tmp/test/fgg/booleans/booleans.fgg

	mkdir -p tmp/test/fgg/compose
	go run oopsla20-91/fgg/cmd/fg2fgg fg/examples/prev/compose/compose.go > tmp/test/fgg/compose/compose.fgg
	go run oopsla20-91/fgg -fgg -eval=-1 tmp/test/fgg/compose/compose.fgg

	mkdir -p tmp/test/fgg/equal
	go run oopsla20-91/fgg/cmd/fg2fgg fg/examples/prev/equal/equal.go > tmp/test/fgg/equal/equal.fgg
	go run oopsla20-91/fgg -fgg -eval=-1 tmp/test/fgg/equal/equal.fgg

	mkdir -p tmp/test/fgg/incr
	go run oopsla20-91/fgg/cmd/fg2fgg fg/examples/prev/incr/incr.go > tmp/test/fgg/incr/incr.fgg
	go run oopsla20-91/fgg -fgg -eval=-1 tmp/test/fgg/incr/incr.fgg

	mkdir -p tmp/test/fgg/map
	go run oopsla20-91/fgg/cmd/fg2fgg fg/examples/prev/map/map.go > tmp/test/fgg/map/map.fgg
	go run oopsla20-91/fgg -fgg -eval=-1 tmp/test/fgg/map/map.fgg

	mkdir -p tmp/test/fgg/not
	go run oopsla20-91/fgg/cmd/fg2fgg fg/examples/prev/not/not.go > tmp/test/fgg/not/not.fgg
	go run oopsla20-91/fgg -fgg -eval=-1 tmp/test/fgg/not/not.fgg

# TODO: run fg_test.go unit tests through fg2fgg


.PHONY: clean-test-fg2fgg
clean-test-fg2fgg:
	rm -f tmp/test/fgg/booleans/booleans.fgg
	rm -fd tmp/test/fgg/booleans

	rm -f tmp/test/fgg/compose/compose.fgg
	rm -fd tmp/test/fgg/compose

	rm -f tmp/test/fgg/equal/equal.fgg
	rm -fd tmp/test/fgg/equal

	rm -f tmp/test/fgg/incr/incr.fgg
	rm -fd tmp/test/fgg/incr

	rm -f tmp/test/fgg/map/map.fgg
	rm -fd tmp/test/fgg/map

	rm -f tmp/test/fgg/not/not.fgg
	rm -fd tmp/test/fgg/not


.PHONY: clean-test-all
clean-test-all: clean-test-fg2fgg clean-test-monom-against-go clean-test-oblit

