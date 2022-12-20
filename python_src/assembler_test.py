import unittest
from assembler import Assembler

class AssemblerTest(unittest.TestCase):
    def test_tokenizer(self):
        asm = Assembler()
        asm_file = open('./src_code_test.asm', encoding='utf-8')
        tokens = asm.tokenizer(asm_file)
        asm_file.close()
        tokens_expected = [['LW', 'R4', '176', 'R0']
                           , ['SUB', 'R2', 'R4', 'R1']
                           , ['BEZ', 'R2', '8']
                           , ['BEZ', 'R0', '-8']
                           , ['J', 'R1'], ['HALT']]
                
        self.assertEqual(tokens, tokens_expected)
        
    def test_str_to_bin_str_pos_val(self):
        asm = Assembler()
        asm_file = open('./src_code_test2.asm', encoding='utf-8')
        tokens = asm.tokenizer(asm_file)
        mocked_binary = "00010"
        rt = tokens[0][2]
        binary = asm.str_to_bin_str(rt, 5)
        self.assertEqual(mocked_binary, binary)

    def test_str_to_bin_str_neg_val(self):
        asm = Assembler()
        asm_file = open('./src_code_test2.asm', encoding='utf-8')
        tokens = asm.tokenizer(asm_file)
        mocked_binary = "11101"
        sa = tokens[0][3]
        binary = asm.str_to_bin_str(sa, 5)
        self.assertEqual(mocked_binary, binary)