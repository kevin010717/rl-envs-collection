#!/usr/bin/env python
"""
通用 Gymnasium 环境测试脚本（IDE 调试版）

在代码内直接配置参数，不用从命令行传参。
"""

import time
import json
import gymnasium as gym


# ==========================================================
# 你要调整的参数都在这里！
# ==========================================================
CONFIG = {
    # "env_id": "CartPole-v1",  # 环境名称，如 AdroitHandPen-v1
    # "env_id": "AdroitHandPen-v1",  
    # "env_id": "BipedalWalker-v3",  
    # "env_id": "Ant-v4",  
    "env_id": "FrankaKitchen-v1",  
    # "env_id": "HumanoidStandup-v4",  
    # "env_id": "Humanoid-v4",  
    # "env_id": "Walker2d-v4",  
    # "env_id": "Hopper-v4",  
    # "env_id": "HalfCheetah-v4",  
    # "env_id": "Pendulum-v1",  
    # "env_id": "MountainCarContinuous-v0",  
    "render_mode": "human",   # human / rgb_array / None
    "episodes": 100,            # 跑多少个 episode
    "max_steps": 500,         # 每个 episode 最多多少步
    "seed": None,             # 随机种子
    "env_kwargs": {},         # gym.make 的额外参数，如 {"hardcore": True}
    "sleep": 0.0,             # 每步暂停（秒）
    "verbose": False,         # 是否打印逐步详细信息
    "print_every": 50,        # verbose 模式下，每多少步打印一次
}

# ==========================================================


def make_env(env_id: str, render_mode: str | None, env_kwargs: dict):
    """创建环境（自动注册 gymnasium-robotics）"""

    try:
        import gymnasium_robotics
        try:
            gym.register_envs(gymnasium_robotics)
        except Exception:
            pass
    except ImportError:
        pass

    kwargs = dict(env_kwargs) if env_kwargs else {}
    if render_mode is not None:
        kwargs.setdefault("render_mode", render_mode)

    env = gym.make(env_id, **kwargs)
    return env


def run(config):
    env_id = config["env_id"]
    render_mode = config["render_mode"]
    episodes = config["episodes"]
    max_steps = config["max_steps"]
    seed = config["seed"]
    env_kwargs = config["env_kwargs"]
    sleep = config["sleep"]
    verbose = config["verbose"]
    print_every = config["print_every"]

    # 创建环境
    env = make_env(env_id, render_mode, env_kwargs)

    print("=== Gymnasium Env Tester (Debug Mode) ===")
    print(f"Env ID        : {env_id}")
    print(f"Render mode   : {render_mode}")
    print(f"Episodes      : {episodes}")
    print(f"Max steps/ep  : {max_steps}")
    print(f"Env kwargs    : {env_kwargs}")
    print("Observation space:", env.observation_space)
    print("Action space      :", env.action_space)
    print("-" * 40)

    for ep in range(episodes):
        reset_seed = seed + ep if seed is not None else None
        obs, info = env.reset(seed=reset_seed)
        ep_reward = 0.0

        for step in range(max_steps):
            action = env.action_space.sample()  # 随机策略
            obs, reward, terminated, truncated, info = env.step(action)
            # ep_reward += reward
            ep_reward += float(reward)
            done = terminated or truncated

            if verbose and (step % print_every == 0 or done):
                print(
                    f"[Ep {ep}] step={step} "
                    f"reward={reward:.3f} ep_return={ep_reward:.3f} "
                    f"terminated={terminated} truncated={truncated}"
                )

            if sleep > 0:
                time.sleep(sleep)

            if done:
                break

        print(f"Episode {ep} finished: steps={step + 1}, total_reward={ep_reward:.3f}")

    env.close()


if __name__ == "__main__":
    run(CONFIG)

    from gymnasium.envs.registration import registry
    for env_id in registry.keys():
        print(env_id)


