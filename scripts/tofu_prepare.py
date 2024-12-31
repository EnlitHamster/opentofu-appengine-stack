import utils
import tofu_init
import tofu_plan


if __name__ == '__main__':
    source = utils.get_tofu_dir()
    print(f'Tofu directory: {source}')

    tofu_init.run(source)
    tofu_plan.run(source)
