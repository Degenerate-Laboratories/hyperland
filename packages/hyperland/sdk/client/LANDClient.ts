/**
 * LAND Token Client
 */

import { Contract, Provider, Signer, parseEther, formatEther } from 'ethers';
import { LAND_ABI } from '../abis';

export class LANDClient {
  private contract: Contract;
  private readOnlyContract: Contract;

  constructor(
    public readonly address: string,
    public readonly provider: Provider,
    public readonly signer?: Signer
  ) {
    this.readOnlyContract = new Contract(address, LAND_ABI, provider);
    this.contract = signer
      ? new Contract(address, LAND_ABI, signer)
      : this.readOnlyContract;
  }

  /**
   * Get token name
   */
  async name(): Promise<string> {
    return await this.readOnlyContract.name();
  }

  /**
   * Get token symbol
   */
  async symbol(): Promise<string> {
    return await this.readOnlyContract.symbol();
  }

  /**
   * Get token decimals
   */
  async decimals(): Promise<number> {
    return await this.readOnlyContract.decimals();
  }

  /**
   * Get total supply
   */
  async totalSupply(): Promise<bigint> {
    return await this.readOnlyContract.totalSupply();
  }

  /**
   * Get balance of an address
   */
  async balanceOf(address: string): Promise<bigint> {
    return await this.readOnlyContract.balanceOf(address);
  }

  /**
   * Get balance formatted as ether string
   */
  async balanceOfFormatted(address: string): Promise<string> {
    const balance = await this.balanceOf(address);
    return formatEther(balance);
  }

  /**
   * Transfer tokens
   */
  async transfer(to: string, amount: bigint) {
    if (!this.signer) throw new Error('Signer required for transfer');
    const tx = await this.contract.transfer(to, amount);
    return await tx.wait();
  }

  /**
   * Transfer tokens with amount in ether string
   */
  async transferEther(to: string, amountEther: string) {
    return await this.transfer(to, parseEther(amountEther));
  }

  /**
   * Approve spender
   */
  async approve(spender: string, amount: bigint) {
    if (!this.signer) throw new Error('Signer required for approve');
    const tx = await this.contract.approve(spender, amount);
    return await tx.wait();
  }

  /**
   * Approve spender with amount in ether string
   */
  async approveEther(spender: string, amountEther: string) {
    return await this.approve(spender, parseEther(amountEther));
  }

  /**
   * Get allowance
   */
  async allowance(owner: string, spender: string): Promise<bigint> {
    return await this.readOnlyContract.allowance(owner, spender);
  }
}
