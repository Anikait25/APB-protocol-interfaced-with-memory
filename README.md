# APB Protocol Interfaced with Memory

## 📝 Description

This project demonstrates the integration of the **AMBA APB (Advanced Peripheral Bus) protocol** with a simple memory module. The APB is used for connecting low-bandwidth peripherals in system-on-chip (SoC) architectures. This design shows how to use APB protocol signals to perform read and write operations on a memory block, typically implemented in Verilog HDL.

## 🔧 Modules Description

### 1. `apb_master.v`
- Initiates read/write transactions.
- Generates APB signals: `PSEL`, `PENABLE`, `PWRITE`, `PADDR`, `PWDATA`.

### 2. `apb_slave.v`
- Decodes APB signals.
- Interfaces with internal memory.
- Provides `PRDATA` during read transactions.

### 3. `memory.v`
- Implements simple memory using a register array (e.g., 256 x 8-bit).
- Supports synchronous write and asynchronous read.

### 4. `top.v`
- Connects APB master and slave.
- Top-level integration module.

### 5. `tb_top.v`
- Testbench to simulate APB read/write operations.
- Generates clock and reset.
- Monitors outputs and validates functionality.

---

## 🧪 Testbench Features

- Simulates:
  - Write operation to a memory address.
  - Read operation from the same address.
  - Check for correct `PRDATA` during read.
- Displays outputs via `$display` or waveform.

---

## 📌 APB Protocol Summary

| Signal     | Direction | Description                           |
|------------|-----------|---------------------------------------|
| `PCLK`     | Input     | Clock signal                          |
| `PRESETn`  | Input     | Active-low reset                      |
| `PSEL`     | Input     | Select signal                         |
| `PENABLE`  | Input     | Enable for data phase                 |
| `PWRITE`   | Input     | Write control (1=Write, 0=Read)       |
| `PADDR`    | Input     | Address bus                           |
| `PWDATA`   | Input     | Write data bus                        |
| `PRDATA`   | Output    | Read data bus                         |
| `PREADY`   | Output    | Indicates slave is ready              |

---

## ✅ Simulation Tool

- **ModelSim / QuestaSim / XSIM / Icarus Verilog**
- **Waveform viewing:** GTKWave or built-in tool

---

## 🚀 How to Run

1. Compile all RTL and testbench files.
2. Run simulation.
3. Observe the memory access transactions.
4. Check waveform or simulation log to verify correct functionality.

---

## 📚 Future Improvements

- Implement multiple APB slaves with address decoding.
- Add APB4 features (e.g., `PREADY`, `PSLVERR`).
- Interface with actual peripheral modules (UART, Timer).
- Create a testbench with randomized transactions.

---

## 👨‍💻 Author

**Anikait Sarkar**  
RSA SEIP VLSI Trainee


