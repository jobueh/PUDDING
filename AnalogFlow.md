# Analog Design Flow  

[This design](./README.md) is a mixed-signal design.  
The digital design flow isn't really applicable.  
  
It is rather counterproductive to do a top down design.  
The proof is in the analog layout pudding, 
and accurate extraction and modeling of the key analog elements.  

## In progress  

* Lay out switched cascode transistor  
    * pmos transistor with  
        * gate contact  
        * drain contact  
        * source connected to current source transistor by pdiffusion abutment  
    * arrangeable in an array by abutment  
        * the width of the cascode transistor, plus the gate contact and poly spacing, 
          determine the width of a unit current source  
    * define as [DRC clean parametrizable cell](https://github.com/tatzelbrumm/klayoutAPI/blob/master/switched_pmos_cascode.py)  
        * cascode length  
        * cascode width  
* Extend cascode transistor to switched cascoded current source  
    * for good matching and low 1/f noise, long and narrow  
    * arrangeable in an array by abutment  
    * shared poly for common bias voltage    
* Mockup [layout of a row of 256 unit current sources](https://github.com/tatzelbrumm/PUDDING/blob/tatzelbranch/gds/pcascsrc256.gds).  
It doesn't make sense to lay out a 256 element thermometer code DAC as one row,  
but this layout (column width: 282&mu;m, height: 4.4&mu;m)  
shows that the analog part of the design will fit within a HeiChips tile comfortably.  

### [Proof-of-concept unit cell](https://github.com/tatzelbrumm/PUDDING/blob/tatzelbranch/gds/swcascsrc_playground.gds)  

width: 1.1&mu;m, height 3.9&mu;m  

#### Layout
![proof-of-concept: array of 16 switched cascoded pmos current sources](pix/swsources16.jpg)    

* [DRC and LvS clean row of 16 unit current sources](https://github.com/jobueh/PUDDING/blob/tatzelbranch/gds/swsources16.gds)  
* [Test schematic with 2 unit sources as reference current mirror, 16 output sources](https://github.com/jobueh/PUDDING/blob/tatzelbranch/xschem/test_pcascsrc16_DC.sch)  

![draft: 2 rows of 64 switched cascoded pmos current sources with 2x2 diode connected reference transistors at the ends of the rows](pix/dac128out4in_draft.jpg)  

* [DRC clean 2x64 unit current sources analog-only layout](https://github.com/jobueh/PUDDING/blob/tatzelbranch/gds/dac128out4in.gds)

* **Design cascode bias generator**  
    * **Create test schematics to characterize g<sub>m</sub>/I<sub>d</sub> and g<sub>m</sub>/g<sub>o</sub> of transistors**  
    * **Create test schematics to characterize g<sub>o</sub> of cascoded current sources as function of voltage**  
* Extend cascode transistor to switched cascoded current source  
    * define as DRC clean parametrizable cell  
        * current source length  
        * current source width  
        * cascode length  
        * cascode width  
* Extract [post-layout netlist for LvS](https://github.com/jobueh/PUDDING/blob/tatzelbranch/gds/PCASCSRC16_extracted.cir)  
  to compare against [xschem schematic](https://github.com/jobueh/PUDDING/blob/tatzelbranch/xschem/simulation/pcascsrc16.spice)  

### Gotchas

* Hierarchical bottom up analog design leads to crashes unless a verified best practice how to reference to [hierarchical klayout libraries](https://github.com/tatzelbrumm/klayoutAPI/tree/master) is established and verified    
    **Problem:** This requires coordination by different domain experts, namely  
    * klayout  
    * IHP analog PDK  
    * IHP analog standard cell library organization  
    * any containers or other virtualization schemes that might be used  
    In discussion forums, you get `#worksforme` answers from experts in *one* of the domains
    that don't take into account side effects.    
    Such answers are **less** than useless.  
    **One** *czar of pcells* needs to be volunteered to establish, publish, and maintain    
    **RECOMMENDED BEST PRACTICES** about directory structures, instantiation hierarchies, how to include sub-layout cells (parametric or not) into klayout GDS files.  
    **Solution for now:** Import sub-`.gds` schematic files into the top level schematic.  
    * Invariant under various and sundry (and subtly incompatible) library integration schemes:    
      The top level `.gds` file is self-contained.
* When thinking how to connect digital outputs to the cascode switches,  
    * the transistors that switch between VDDA and V<sub>casc,P</sub> should be directly adjacent to the switched sources  
    * the pinout and form factor of the digital logic driving a row of 64 current sources needs to have matching form factor and pinout.
* Connecting V<sub>bias,p</sub> by poly abutment is *not* just a bad idea because at cryogenic temperatures, poly may become highly resistive. *(Solved)*  
    It is also advantageous to shield the current sources by `metal1`  
    * so the connections to the switch/cascode transistors can be routed on top of the current sources without adverse effects on matching.  
    * `metal1` density rules are met without random `metal1` fill on the most mismatch sensitive analog transistors.  

## To do  

* Extract post-layout netlist with parasitics  
* Use suitable device models  
    * that can handle millikelvin temperatures  
    * Make the models available in the open environment  
    * If the models don't exist, write them  

* Find out how to generate analog/mixed signal pad frames  
    * Preferably without involving the librelane overhead  
        * Look at Krzysztof Herman's repositories and examples  
    * Suitable for stand-alone submission of designs 
        * in the last free IHP BiCMOS run  
        * in the last free IHP CMOS engineering run  
        * Find valid reasons to submit designs on later IHP characterization runs  

* Design input current sinks for unit current generation  
    * External input pad  
    * on-chip current reference (if sufficient time and support)  

## References  

[IHP Open PDK](https://github.com/IHP-GmbH/IHP-Open-PDK/)  
[IHP Open PDK docs](https://github.com/IHP-GmbH/IHP-Open-PDK-docs/)  
