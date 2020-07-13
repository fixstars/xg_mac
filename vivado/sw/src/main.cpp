#include <cstdio>
#include <cstdint>

#include <xparameters.h>

enum class AXIFIFORegs
{
    ISR = 0,
    IER,
    TDFR,
    TDFV,
    TDFD,
    TLR,
    RDFR,
    RDFO,
    RDFD,
    RLR,
    SRR,
    TDR,
    RDR,
};

static volatile uint32_t& fifo0_reg(AXIFIFORegs reg) { return *reinterpret_cast<volatile std::uint32_t*>(XPAR_HIER_MAC_0_AXI_FIFO_MM_S_0_BASEADDR + static_cast<std::uint32_t>(reg)*4); }
static volatile uint32_t& fifo1_reg(AXIFIFORegs reg) { return *reinterpret_cast<volatile std::uint32_t*>(XPAR_HIER_MAC_1_AXI_FIFO_MM_S_0_BASEADDR + static_cast<std::uint32_t>(reg)*4); }
static constexpr std::size_t WordsToTransfer = 64;

int main(void)
{
    fifo0_reg(AXIFIFORegs::TDFR) = 1;
    fifo1_reg(AXIFIFORegs::RDFR) = 1;

    printf("Transmitting data...");
    for(std::size_t word = 0; word < WordsToTransfer; word++ ) {
        fifo0_reg(AXIFIFORegs::TDFD) = word;
    }
    fifo0_reg(AXIFIFORegs::TLR) = WordsToTransfer*4;

    printf("Receiving data...");
    while(!(fifo1_reg(AXIFIFORegs::ISR) & (1u<<26)));
    
    auto transferred = fifo1_reg(AXIFIFORegs::RLR);
    if( WordsToTransfer*4 != transferred ) printf("Error: number of bytes transferred is wrong. expected: %d, actual: %d\n", WordsToTransfer*4, transferred);

    for(std::size_t word = 0; word < transferred/4; word++ ) {
        auto value = fifo1_reg(AXIFIFORegs::RDFD);
        if( word != value ) printf("Error: value mismatch #%03d: expected: %d, actual: %d\n", word, word, value);
    }
    printf("Done.");
    return 0;
}
